<div class="panel-card"><div class="card-header"><h3>البقشيش</h3></div><div class="card-body">
<p>إجمالي المدفوع: <strong><?= format_price($tip_stats['total_tips'] ?? 0) ?></strong> | متوسط: <strong><?= format_price($tip_stats['avg_tip'] ?? 0) ?></strong></p>
<table class="data-table"><thead><tr><th>الطلب</th><th>العميل</th><th>المندوب</th><th>القيمة</th><th>الحالة</th></tr></thead><tbody><?php foreach (($tips ?? []) as $t): ?><tr><td><?= escape($t['order_number']) ?></td><td><?= escape($t['user_name']) ?></td><td><?= escape($t['driver_name']) ?></td><td><?= format_price($t['amount']) ?></td><td><?= escape($t['status']) ?></td></tr><?php endforeach; ?></tbody></table>
</div></div>
