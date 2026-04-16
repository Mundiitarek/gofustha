<?php
/**
 * صفحة إنشاء حساب جديد (أدمن، تاجر، مندوب، عميل)
 * Saree3 - تطبيق توصيل ومارت
 * 
 * تحذير: احذف هذا الملف بعد الاستخدام في بيئة الإنتاج!
 */

require_once __DIR__ . '/config/config.php';
require_once __DIR__ . '/includes/auth.php';
require_once __DIR__ . '/includes/helpers.php';

// توافق مع البيئات التي لم تُحدّث includes/auth.php بعد
if (!function_exists('get_phone_lookup_candidates')) {
    function get_phone_lookup_candidates($phone) {
        $candidates = [];
        $raw = trim((string)$phone);
        $normalized = normalize_phone($raw);
        $formatted = format_saudi_phone($raw);

        foreach ([$raw, $normalized, $formatted] as $value) {
            $value = trim((string)$value);
            if ($value !== '') {
                $candidates[] = $value;
            }
        }

        return array_values(array_unique($candidates));
    }
}

$message = '';
$message_type = 'info';

// =====================================================
// معالجة إنشاء الحساب
// =====================================================
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['create_account'])) {
    $account_type = $_POST['account_type'] ?? 'customer';
    $phone_input = $_POST['phone'] ?? '';
    $phone = format_saudi_phone($phone_input);
    $phone_candidates = get_phone_lookup_candidates($phone_input);
    $password = $_POST['password'] ?? '';
    $name = trim($_POST['name'] ?? '');
    $business_name = trim($_POST['business_name'] ?? '');
    $business_type = $_POST['business_type'] ?? 'restaurant';
    $vehicle_type = $_POST['vehicle_type'] ?? 'motorcycle';
    $vehicle_number = trim($_POST['vehicle_number'] ?? '');
    $zone_id = (int)($_POST['zone_id'] ?? 0);
    $role = $_POST['role'] ?? 'manager';
    
    // التحقق من البيانات الأساسية
    if (!is_valid_phone($phone)) {
        $message = 'رقم الجوال غير صحيح';
        $message_type = 'error';
    } elseif (empty($name)) {
        $message = 'الاسم مطلوب';
        $message_type = 'error';
    } elseif ($account_type != 'customer' && empty($password)) {
        $message = 'كلمة المرور مطلوبة';
        $message_type = 'error';
    } else {
        
        switch ($account_type) {
            case 'admin':
                $placeholders = implode(',', array_fill(0, count($phone_candidates), '?'));
                $existing = db_fetch("SELECT id FROM admins WHERE phone IN ($placeholders) LIMIT 1", $phone_candidates);
                if ($existing) {
                    $message = 'رقم الجوال مستخدم بالفعل كأدمن';
                    $message_type = 'error';
                } else {
                    db_insert('admins', [
                        'name' => $name,
                        'phone' => $phone,
                        'password_hash' => password_hash($password, PASSWORD_DEFAULT),
                        'role' => $role,
                        'status' => 1,
                        'created_at' => date('Y-m-d H:i:s')
                    ]);
                    $message = "تم إنشاء حساب الأدمن بنجاح!\nالهاتف: $phone\nكلمة المرور: $password";
                    $message_type = 'success';
                }
                break;
                
            case 'vendor':
                $placeholders = implode(',', array_fill(0, count($phone_candidates), '?'));
                $existing = db_fetch("SELECT id FROM vendors WHERE phone IN ($placeholders) LIMIT 1", $phone_candidates);
                if ($existing) {
                    $message = 'رقم الجوال مستخدم بالفعل كتاجر';
                    $message_type = 'error';
                } elseif (empty($business_name)) {
                    $message = 'اسم المتجر مطلوب';
                    $message_type = 'error';
                } else {
                    // لو مفيش zone، نجيب أول واحد
                    if (!$zone_id) {
                        $zone = db_fetch("SELECT id FROM zones WHERE status = 1 LIMIT 1");
                        $zone_id = $zone['id'] ?? null;
                        
                        // لو لسه مفيش، ننشئ واحد
                        if (!$zone_id) {
                            $zone_id = db_insert('zones', [
                                'name_ar' => 'وسط المدينة',
                                'city' => 'الرياض',
                                'status' => 1,
                                'created_at' => date('Y-m-d H:i:s')
                            ]);
                        }
                    }
                    
                    db_insert('vendors', [
                        'name' => $name,
                        'phone' => $phone,
                        'password_hash' => password_hash($password, PASSWORD_DEFAULT),
                        'business_name' => $business_name,
                        'business_type' => $business_type,
                        'zone_id' => $zone_id,
                        'min_order' => 50,
                        'delivery_time' => '30-45 دقيقة',
                        'commission_rate' => 10,
                        'is_open' => 1,
                        'status' => 'approved',
                        'created_at' => date('Y-m-d H:i:s')
                    ]);
                    $message = "تم إنشاء حساب التاجر بنجاح!\nالهاتف: $phone\nكلمة المرور: $password\nالمتجر: $business_name";
                    $message_type = 'success';
                }
                break;
                
            case 'driver':
                $placeholders = implode(',', array_fill(0, count($phone_candidates), '?'));
                $existing = db_fetch("SELECT id FROM drivers WHERE phone IN ($placeholders) LIMIT 1", $phone_candidates);
                if ($existing) {
                    $message = 'رقم الجوال مستخدم بالفعل كمندوب';
                    $message_type = 'error';
                } else {
                    if (!$zone_id) {
                        $zone = db_fetch("SELECT id FROM zones WHERE status = 1 LIMIT 1");
                        $zone_id = $zone['id'] ?? 1;
                    }
                    
                    db_insert('drivers', [
                        'name' => $name,
                        'phone' => $phone,
                        'password_hash' => password_hash($password, PASSWORD_DEFAULT),
                        'vehicle_type' => $vehicle_type,
                        'vehicle_number' => $vehicle_number,
                        'zone_id' => $zone_id,
                        'is_online' => 0,
                        'is_busy' => 0,
                        'status' => 'approved',
                        'created_at' => date('Y-m-d H:i:s')
                    ]);
                    $message = "تم إنشاء حساب المندوب بنجاح!\nالهاتف: $phone\nكلمة المرور: $password";
                    $message_type = 'success';
                }
                break;
                
            case 'customer':
                $placeholders = implode(',', array_fill(0, count($phone_candidates), '?'));
                $existing = db_fetch("SELECT id FROM users WHERE phone IN ($placeholders) LIMIT 1", $phone_candidates);
                if ($existing) {
                    $message = 'رقم الجوال مستخدم بالفعل كعميل';
                    $message_type = 'error';
                } else {
                    db_insert('users', [
                        'name' => $name,
                        'phone' => $phone,
                        'status' => 1,
                        'created_at' => date('Y-m-d H:i:s')
                    ]);
                    $message = "تم إنشاء حساب العميل بنجاح!\nالهاتف: $phone\n(يستخدم OTP للدخول)";
                    $message_type = 'success';
                }
                break;
        }
    }
}

// جلب المناطق للاختيار
$zones = db_fetch_all("SELECT id, name_ar, city FROM zones WHERE status = 1 ORDER BY city, name_ar", []);

?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>إنشاء حساب جديد - سريع</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            direction: rtl;
        }
        
        .container {
            max-width: 600px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            color: white;
            margin-bottom: 30px;
        }
        
        .header h1 {
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }
        
        .header p {
            opacity: 0.9;
            font-size: 15px;
        }
        
        .warning-banner {
            background: #FEF3C7;
            border: 2px solid #F59E0B;
            border-radius: 16px;
            padding: 14px 18px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: #92400E;
        }
        
        .warning-banner i {
            font-size: 24px;
            color: #F59E0B;
        }
        
        .card {
            background: white;
            border-radius: 24px;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #374151;
            font-size: 14px;
        }
        
        .form-group label i {
            color: #667eea;
            margin-left: 6px;
        }
        
        .form-control {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #E5E7EB;
            border-radius: 14px;
            font-size: 15px;
            font-family: 'Cairo', sans-serif;
            transition: all 0.2s;
            background: white;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }
        
        .phone-wrapper {
            display: flex;
            align-items: center;
            border: 2px solid #E5E7EB;
            border-radius: 14px;
            overflow: hidden;
            transition: all 0.2s;
            background: white;
        }
        
        .phone-wrapper:focus-within {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }
        
        .country-code {
            padding: 0 16px;
            background: #F9FAFB;
            color: #374151;
            font-weight: 600;
            font-size: 15px;
            line-height: 52px;
            border-left: 2px solid #E5E7EB;
        }
        
        .phone-wrapper .form-control {
            border: none;
            border-radius: 0;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }
        
        .account-types {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-bottom: 20px;
        }
        
        .type-option {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px;
            background: #F9FAFB;
            border: 2px solid #E5E7EB;
            border-radius: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .type-option:hover {
            border-color: #667eea;
            background: #EEF2FF;
        }
        
        .type-option.selected {
            border-color: #667eea;
            background: #EEF2FF;
        }
        
        .type-option input {
            display: none;
        }
        
        .type-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }
        
        .type-icon.admin { background: #FEE2E2; color: #DC2626; }
        .type-icon.vendor { background: #D1FAE5; color: #059669; }
        .type-icon.driver { background: #FEF3C7; color: #D97706; }
        .type-icon.customer { background: #E9D5FF; color: #7C3AED; }
        
        .type-info h3 {
            font-size: 15px;
            margin-bottom: 2px;
            color: #1F2937;
        }
        
        .type-info p {
            font-size: 12px;
            color: #6B7280;
        }
        
        .conditional-fields {
            display: none;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px dashed #E5E7EB;
        }
        
        .conditional-fields.active {
            display: block;
        }
        
        .btn {
            width: 100%;
            padding: 16px;
            border: none;
            border-radius: 14px;
            font-weight: 700;
            font-size: 16px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.2s;
            font-family: 'Cairo', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }
        
        .btn i {
            font-size: 18px;
        }
        
        .alert {
            padding: 16px 20px;
            border-radius: 14px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .alert-success {
            background: #D1FAE5;
            color: #065F46;
            border: 1px solid #A7F3D0;
        }
        
        .alert-error {
            background: #FEE2E2;
            color: #991B1B;
            border: 1px solid #FECACA;
        }
        
        .alert i {
            font-size: 22px;
        }
        
        .result-box {
            background: #1F2937;
            border-radius: 14px;
            padding: 16px;
            margin-top: 20px;
            color: #10B981;
            font-family: monospace;
            font-size: 14px;
            white-space: pre-line;
            line-height: 1.8;
        }
        
        .copy-btn {
            margin-top: 10px;
            padding: 10px;
            background: #374151;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-family: 'Cairo', sans-serif;
            font-size: 13px;
            width: 100%;
        }
        
        .copy-btn:hover {
            background: #4B5563;
        }
        
        .quick-links {
            margin-top: 20px;
            text-align: center;
        }
        
        .quick-links a {
            color: white;
            text-decoration: none;
            opacity: 0.8;
            font-size: 14px;
        }
        
        .quick-links a:hover {
            opacity: 1;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>
            <i class="fas fa-user-plus"></i>
            إنشاء حساب جديد
        </h1>
        <p>أدخل البيانات لإنشاء حساب (أدمن، تاجر، مندوب، أو عميل)</p>
    </div>
    
    <div class="warning-banner">
        <i class="fas fa-exclamation-triangle"></i>
        <div>
            <strong>تحذير هام!</strong>
            <p>هذه الصفحة للاستخدام التطويري فقط. احذفها قبل رفع المشروع للإنتاج.</p>
        </div>
    </div>
    
    <?php if ($message): ?>
    <div class="alert alert-<?= $message_type ?>">
        <i class="fas fa-<?= $message_type == 'success' ? 'check-circle' : 'times-circle' ?>"></i>
        <span><?= nl2br(htmlspecialchars($message)) ?></span>
    </div>
    
    <?php if ($message_type == 'success'): ?>
    <div class="result-box" id="resultText">
        <?= htmlspecialchars($message) ?>
    </div>
    <button class="copy-btn" onclick="copyResult()">
        <i class="fas fa-copy"></i> نسخ البيانات
    </button>
    <?php endif; ?>
    <?php endif; ?>
    
    <div class="card">
        <form method="POST">
            <div class="form-group">
                <label><i class="fas fa-tag"></i> نوع الحساب</label>
                <div class="account-types">
                    <label class="type-option" id="typeAdmin">
                        <input type="radio" name="account_type" value="admin" onchange="toggleAccountType('admin')">
                        <div class="type-icon admin"><i class="fas fa-user-shield"></i></div>
                        <div class="type-info">
                            <h3>أدمن</h3>
                            <p>صلاحيات كاملة</p>
                        </div>
                    </label>
                    
                    <label class="type-option" id="typeVendor">
                        <input type="radio" name="account_type" value="vendor" onchange="toggleAccountType('vendor')">
                        <div class="type-icon vendor"><i class="fas fa-store"></i></div>
                        <div class="type-info">
                            <h3>تاجر</h3>
                            <p>مطعم أو متجر</p>
                        </div>
                    </label>
                    
                    <label class="type-option" id="typeDriver">
                        <input type="radio" name="account_type" value="driver" onchange="toggleAccountType('driver')">
                        <div class="type-icon driver"><i class="fas fa-motorcycle"></i></div>
                        <div class="type-info">
                            <h3>مندوب</h3>
                            <p>توصيل الطلبات</p>
                        </div>
                    </label>
                    
                    <label class="type-option" id="typeCustomer" data-selected="true">
                        <input type="radio" name="account_type" value="customer" checked onchange="toggleAccountType('customer')">
                        <div class="type-icon customer"><i class="fas fa-user"></i></div>
                        <div class="type-info">
                            <h3>عميل</h3>
                            <p>يطلب من التطبيق</p>
                        </div>
                    </label>
                </div>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-user"></i> الاسم الكامل</label>
                <input type="text" name="name" class="form-control" placeholder="مثال: أحمد محمد" required>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-phone"></i> رقم الجوال</label>
                <div class="phone-wrapper">
                    <span class="country-code">+966</span>
                    <input type="tel" name="phone" class="form-control" placeholder="5xxxxxxxx" maxlength="9" inputmode="numeric" required>
                </div>
            </div>
            
            <div class="form-group" id="passwordField">
                <label><i class="fas fa-lock"></i> كلمة المرور</label>
                <input type="text" name="password" id="passwordInput" class="form-control" placeholder="اتركه فارغاً للعميل">
            </div>
            
            <!-- حقول الأدمن -->
            <div class="conditional-fields" id="adminFields">
                <div class="form-group">
                    <label><i class="fas fa-user-tag"></i> الدور</label>
                    <select name="role" class="form-control">
                        <option value="super">مدير عام</option>
                        <option value="manager">مدير</option>
                        <option value="support">دعم فني</option>
                    </select>
                </div>
            </div>
            
            <!-- حقول التاجر -->
            <div class="conditional-fields" id="vendorFields">
                <div class="form-group">
                    <label><i class="fas fa-store-alt"></i> اسم المتجر</label>
                    <input type="text" name="business_name" class="form-control" placeholder="مثال: مطعم البيتزا الإيطالية">
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-tag"></i> نوع المتجر</label>
                        <select name="business_type" class="form-control">
                            <option value="restaurant">مطعم</option>
                            <option value="mart">مارت</option>
                            <option value="both">كلاهما</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-map-pin"></i> المنطقة</label>
                        <select name="zone_id" class="form-control">
                            <option value="">افتراضي</option>
                            <?php foreach ($zones as $zone): ?>
                            <option value="<?= $zone['id'] ?>"><?= htmlspecialchars($zone['city'] . ' - ' . $zone['name_ar']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>
            </div>
            
            <!-- حقول المندوب -->
            <div class="conditional-fields" id="driverFields">
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-motorcycle"></i> نوع المركبة</label>
                        <select name="vehicle_type" class="form-control">
                            <option value="motorcycle">دراجة نارية</option>
                            <option value="car">سيارة</option>
                            <option value="bicycle">دراجة هوائية</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-id-card"></i> رقم المركبة</label>
                        <input type="text" name="vehicle_number" class="form-control" placeholder="اختياري">
                    </div>
                </div>
                <div class="form-group">
                    <label><i class="fas fa-map-pin"></i> المنطقة</label>
                    <select name="zone_id" class="form-control">
                        <option value="">افتراضي</option>
                        <?php foreach ($zones as $zone): ?>
                        <option value="<?= $zone['id'] ?>"><?= htmlspecialchars($zone['city'] . ' - ' . $zone['name_ar']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
            </div>
            
            <button type="submit" name="create_account" class="btn">
                <i class="fas fa-user-plus"></i>
                إنشاء الحساب
            </button>
        </form>
    </div>
    
    <div class="quick-links">
        <a href="<?= BASE_URL ?>">العودة للرئيسية</a>
        &nbsp;|&nbsp;
        <a href="<?= BASE_URL ?>admin/">لوحة الأدمن</a>
        &nbsp;|&nbsp;
        <a href="<?= BASE_URL ?>login.php">تسجيل الدخول</a>
    </div>
</div>

<script>
// تفعيل اختيار نوع الحساب
function toggleAccountType(type) {
    // إخفاء كل الحقول
    document.getElementById('adminFields').classList.remove('active');
    document.getElementById('vendorFields').classList.remove('active');
    document.getElementById('driverFields').classList.remove('active');
    
    // إزالة التحديد من كل الأنواع
    document.querySelectorAll('.type-option').forEach(el => el.classList.remove('selected'));
    
    // تفعيل النوع المختار
    if (type === 'admin') {
        document.getElementById('adminFields').classList.add('active');
        document.getElementById('typeAdmin').classList.add('selected');
        document.getElementById('passwordField').style.display = 'block';
    } else if (type === 'vendor') {
        document.getElementById('vendorFields').classList.add('active');
        document.getElementById('typeVendor').classList.add('selected');
        document.getElementById('passwordField').style.display = 'block';
    } else if (type === 'driver') {
        document.getElementById('driverFields').classList.add('active');
        document.getElementById('typeDriver').classList.add('selected');
        document.getElementById('passwordField').style.display = 'block';
    } else {
        document.getElementById('typeCustomer').classList.add('selected');
        document.getElementById('passwordField').style.display = 'none';
    }
}

// تفعيل النوع الافتراضي (عميل)
document.addEventListener('DOMContentLoaded', function() {
    toggleAccountType('customer');
    
    // تحديد النوع من الراديو
    document.querySelectorAll('input[name="account_type"]').forEach(radio => {
        radio.addEventListener('change', function() {
            toggleAccountType(this.value);
        });
    });
});

// نسخ النتيجة
function copyResult() {
    const text = document.getElementById('resultText').innerText;
    navigator.clipboard.writeText(text).then(() => {
        alert('تم نسخ البيانات إلى الحافظة!');
    });
}

// أزرار الباسورد السريعة
document.addEventListener('keydown', function(e) {
    // لو ضغط Ctrl + G يولد باسورد عشوائي
    if (e.ctrlKey && e.key === 'g') {
        e.preventDefault();
        const randomPass = Math.random().toString(36).slice(-8) + '@' + Math.random().toString(36).slice(-3);
        document.getElementById('passwordInput').value = randomPass;
    }
});
</script>

</body>
</html>
