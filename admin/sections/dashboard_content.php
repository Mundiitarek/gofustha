<div class="stats-grid" style="display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:12px;">
  <div class="stat-card"><h4>العملاء</h4><strong><?= (int)($stats['total_users'] ?? 0) ?></strong></div>
  <div class="stat-card"><h4>التجار</h4><strong><?= (int)($stats['total_vendors'] ?? 0) ?></strong></div>
  <div class="stat-card"><h4>المناديب</h4><strong><?= (int)($stats['total_drivers'] ?? 0) ?></strong></div>
  <div class="stat-card"><h4>الطلبات</h4><strong><?= (int)($stats['total_orders'] ?? 0) ?></strong></div>
  <div class="stat-card"><h4>إيراد اليوم</h4><strong><?= format_price($stats['revenue_today'] ?? 0) ?></strong></div>
  <div class="stat-card"><h4>إيراد الشهر</h4><strong><?= format_price($stats['revenue_this_month'] ?? 0) ?></strong></div>
</div>

<div class="panel-card" style="margin-top:16px;"><div class="card-header"><h3>آخر الطلبات</h3></div><div class="card-body">
<table class="data-table"><thead><tr><th>#</th><th>العميل</th><th>المتجر</th><th>الحالة</th><th>الإجمالي</th></tr></thead><tbody>
<?php foreach (($recent_orders ?? []) as $order): ?>
<tr>
  <td><?= escape($order['order_number']) ?></td>
  <td><?= escape($order['user_name']) ?></td>
  <td><?= escape($order['vendor_name']) ?></td>
  <td><?= renderStatusBadge($order['status']) ?></td>
  <td><?= format_price($order['total']) ?></td>
</tr>
<?php endforeach; ?>
</tbody></table>
</div></div>
