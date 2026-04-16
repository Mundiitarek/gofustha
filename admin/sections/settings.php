<div class="panel-card"><div class="card-header"><h3>إعدادات النظام</h3></div><div class="card-body">
<form method="post"><?= csrf_field() ?><input type="hidden" name="action" value="update_settings">
<table class="data-table"><thead><tr><th>المفتاح</th><th>القيمة</th></tr></thead><tbody>
<?php foreach (($settings ?? []) as $s): ?>
<tr><td><?= escape($s['setting_key']) ?></td><td><input style="width:100%" name="settings[<?= escape($s['setting_key']) ?>]" value="<?= escape($s['setting_value']) ?>"></td></tr>
<?php endforeach; ?>
</tbody></table>
<button class="btn btn-primary" type="submit">حفظ الإعدادات</button>
</form></div></div>
