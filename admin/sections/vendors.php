<div class="panel-card"><div class="card-header"><h3>إدارة التجار</h3></div><div class="card-body">
<table class="data-table"><thead><tr><th>المتجر</th><th>الهاتف</th><th>المنطقة</th><th>الحالة</th><th>تحكم</th></tr></thead><tbody>
<?php foreach (($vendors ?? []) as $v): ?>
<tr>
<td><?= escape($v['business_name']) ?></td><td><?= escape($v['phone']) ?></td><td><?= escape($v['zone_name'] ?? '-') ?></td><td><?= renderStatusBadge($v['status']) ?></td>
<td>
<?php if ($v['status'] !== 'approved'): ?><form method="post" style="display:inline-block"><?= csrf_field() ?><input type="hidden" name="action" value="approve_vendor"><input type="hidden" name="vendor_id" value="<?= (int)$v['id'] ?>"><button class="btn btn-sm">قبول</button></form><?php endif; ?>
<form method="post" style="display:inline-block"><?= csrf_field() ?><input type="hidden" name="action" value="suspend_vendor"><input type="hidden" name="vendor_id" value="<?= (int)$v['id'] ?>"><button class="btn btn-sm">تعليق</button></form>
</td></tr>
<?php endforeach; ?></tbody></table></div></div>
