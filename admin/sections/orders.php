<div class="panel-card"><div class="card-header"><h3>إدارة الطلبات</h3></div><div class="card-body">
<table class="data-table"><thead><tr><th>رقم الطلب</th><th>العميل</th><th>المتجر</th><th>المندوب</th><th>الحالة</th><th>الإجمالي</th></tr></thead><tbody>
<?php foreach (($orders ?? []) as $o): ?>
<tr><td><?= escape($o['order_number']) ?></td><td><?= escape($o['user_name']) ?></td><td><?= escape($o['vendor_name']) ?></td><td><?= escape($o['driver_name'] ?? '-') ?></td><td><?= renderStatusBadge($o['status']) ?></td><td><?= format_price($o['total']) ?></td></tr>
<?php endforeach; ?></tbody></table></div></div>
