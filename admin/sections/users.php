<div class="panel-card"><div class="card-header"><h3>إدارة العملاء</h3></div><div class="card-body">
<form method="get" style="margin-bottom:12px;display:flex;gap:8px;">
  <input type="hidden" name="section" value="users">
  <input type="text" name="search" placeholder="بحث بالاسم/الهاتف" value="<?= escape($_GET['search'] ?? '') ?>">
  <button class="btn btn-primary" type="submit">بحث</button>
</form>
<table class="data-table"><thead><tr><th>الاسم</th><th>الهاتف</th><th>الحالة</th><th>إجراء سريع</th></tr></thead><tbody>
<?php foreach (($users ?? []) as $u): ?>
<tr>
  <td><?= escape($u['name']) ?></td><td><?= escape($u['phone']) ?></td>
  <td><?= !empty($u['is_blocked']) ? renderStatusBadge('blocked') : renderStatusBadge('active') ?></td>
  <td>
    <form method="post" style="display:inline-block;">
      <?= csrf_field() ?><input type="hidden" name="action" value="update_user"><input type="hidden" name="user_id" value="<?= (int)$u['id'] ?>">
      <input type="hidden" name="name" value="<?= escape($u['name']) ?>">
      <input type="hidden" name="block_reason" value="<?= !empty($u['is_blocked']) ? '' : 'حظر بواسطة الأدمن' ?>">
      <label style="display:inline-flex;align-items:center;gap:4px;"><input type="checkbox" name="is_blocked" value="1" <?= !empty($u['is_blocked']) ? '' : 'checked' ?>><?= !empty($u['is_blocked']) ? 'فك الحظر' : 'حظر' ?></label>
      <button class="btn btn-sm" type="submit">تأكيد</button>
    </form>
  </td>
</tr>
<?php endforeach; ?></tbody></table></div></div>
