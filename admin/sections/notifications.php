<div class="panel-card"><div class="card-header"><h3>إرسال إشعار</h3></div><div class="card-body">
<form method="post" style="display:grid;gap:10px;max-width:560px;"><?= csrf_field() ?><input type="hidden" name="action" value="send_notification">
<select name="user_type"><option value="all">الكل</option><option value="user">العملاء</option><option value="vendor">التجار</option><option value="driver">المناديب</option></select>
<input name="title" placeholder="عنوان الإشعار" required>
<textarea name="message" placeholder="نص الإشعار" required></textarea>
<button class="btn btn-primary">إرسال</button></form></div></div>
