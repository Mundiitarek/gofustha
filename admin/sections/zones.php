<div class="panel-card"><div class="card-header"><h3>المناطق ورسوم التوصيل</h3></div><div class="card-body">
<form method="post" style="display:flex;gap:8px;flex-wrap:wrap; margin-bottom:12px;"><?= csrf_field() ?><input type="hidden" name="action" value="add_zone"><input name="name_ar" placeholder="اسم المنطقة" required><input name="city" placeholder="المدينة" required><button class="btn btn-primary">إضافة منطقة</button></form>
<table class="data-table"><thead><tr><th>المنطقة</th><th>المدينة</th><th>الحالة</th></tr></thead><tbody><?php foreach (($zones ?? []) as $z): ?><tr><td><?= escape($z['name_ar']) ?></td><td><?= escape($z['city']) ?></td><td><?= !empty($z['status']) ? 'نشطة' : 'موقفة' ?></td></tr><?php endforeach; ?></tbody></table>
</div></div>
