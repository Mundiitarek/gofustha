<div class="panel-card"><div class="card-header"><h3>إدارة المناديب</h3></div><div class="card-body">
<table class="data-table"><thead><tr><th>الاسم</th><th>الهاتف</th><th>المركبة</th><th>الحالة</th><th>تحكم</th></tr></thead><tbody>
<?php foreach (($drivers ?? []) as $d): ?>
<tr><td><?= escape($d['name']) ?></td><td><?= escape($d['phone']) ?></td><td><?= escape($d['vehicle_type']) ?></td><td><?= renderStatusBadge($d['status']) ?></td><td>
<?php if ($d['status'] !== 'approved'): ?><form method="post" style="display:inline-block"><?= csrf_field() ?><input type="hidden" name="action" value="approve_driver"><input type="hidden" name="driver_id" value="<?= (int)$d['id'] ?>"><button class="btn btn-sm">قبول</button></form><?php endif; ?>
<form method="post" style="display:inline-block"><?= csrf_field() ?><input type="hidden" name="action" value="suspend_driver"><input type="hidden" name="driver_id" value="<?= (int)$d['id'] ?>"><button class="btn btn-sm">تعليق</button></form>
</td></tr>
<?php endforeach; ?></tbody></table></div></div>
