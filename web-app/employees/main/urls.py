from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='jobtitle'),
    path('employee', views.employee, name='employee'),
    path('addemployee', views.addemployee, name='addemployee'),
    path('addjobtitle', views.addjobtitle, name='addjobtitle'),
    path('editjobtitle/<int:job_title_id>', views.editjobtitle, name='editjobtitle'),
    path('editemployee/<int:employee_id>', views.editemployee, name='editemployee'),
]
