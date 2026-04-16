<div class="panel-card"><div class="card-header"><h3>الإحصائيات المتقدمة</h3></div><div class="card-body">
<p>الطلبات شهرياً:</p>
<table class="data-table"><thead><tr><th>الشهر</th><th>عدد الطلبات</th><th>الإيراد</th></tr></thead><tbody><?php foreach (($orders_by_month ?? []) as $m): ?><tr><td><?= escape($m['month']) ?></td><td><?= (int)$m['count'] ?></td><td><?= format_price($m['revenue']) ?></td></tr><?php endforeach; ?></tbody></table>
</div></div>
