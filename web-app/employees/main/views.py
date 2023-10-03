from django.shortcuts import render, redirect
from django.urls import reverse
from django.db import connection


#Форма Должностей
def index(request):
    with connection.cursor() as cursor:
        cursor.execute(''' SELECT "jobTitle"."jobTitle_id", "jobTitle"."jobTitleName",
            category."categoryName"
            FROM "jobTitle"
            JOIN category ON "jobTitle".category_id = category.category_id;
        ''')
        result = cursor.fetchall()

    if request.method == 'POST':
        #Кнопка Изменить
        if 'edit_button' in request.POST:
            job_title_id = request.POST['edit_button']
            return redirect('editjobtitle', job_title_id=int(job_title_id))

        #Кнопка Удалить
        elif 'delete_button' in request.POST:
            job_title_id = request.POST['delete_button']
            with connection.cursor() as cursor:
                cursor.execute('DELETE FROM "jobTitle" WHERE "jobTitle_id" = %s;', [job_title_id])
                return redirect('jobtitle')

        #Кнопка Добавить
        elif 'add_button' in request.POST:
            return redirect(reverse('addjobtitle'))

    context = {'data': result}
    return render(request, 'main/index.html', context)

#Форма изменения должности
def editjobtitle(request, job_title_id):
    if request.method == 'POST':
        jobtitlename = request.POST.get('jobtitlename')
        category = request.POST.get('category')

        #Проверка на заполненность полей
        if not jobtitlename:
            error_message = "Пожалуйста, заполните все поля."
            return render(request, 'main/editjobtitle.html', {'error_message': error_message})
        
        with connection.cursor() as cursor:
            query = '''UPDATE public."jobTitle" SET "jobTitleName" = %s, category_id= %s WHERE "jobTitle_id" = %s;'''
            cursor.execute(query, [jobtitlename, category, job_title_id])
        
        return redirect(reverse('jobtitle'))

    context = {
        'job_title_id': job_title_id,
    }

    return render(request, 'main/editjobtitle.html', context)

#Форма добавления должности
def addjobtitle(request):
    if request.method == 'POST':
        jobtitlename = request.POST.get('jobtitlename')
        category = request.POST.get('category')

        #Проверка на заполненность полей
        if not jobtitlename:
            error_message = "Пожалуйста, заполните все поля."
            return render(request, 'main/addjobtitle.html', {'error_message': error_message})
        
        with connection.cursor() as cursor:
            query = '''INSERT INTO public."jobTitle"("jobTitleName", category_id) VALUES ( %s, %s);'''
            cursor.execute(query, [jobtitlename, category])

        return redirect(reverse('jobtitle'))

    return render(request, 'main/addjobtitle.html')

#Форма с сотрудниками
def employee(request):
    with connection.cursor() as cursor:
        cursor.execute('''SELECT employee."employee_id",
            employee."employeeSurname",
            employee."employeeName",
            employee."employeePatronymic",
            gender."genderName",
            employee."employeeAge",
            "jobTitle"."jobTitleName",
            category."categoryName"
            FROM employee
            JOIN gender ON gender.gender_id = employee.gender_id
            JOIN "jobTitle" ON "jobTitle"."jobTitle_id" = employee."jobTitle_id"
            JOIN category ON category.category_id = "jobTitle".category_id;
        ''')
        result = cursor.fetchall()

    #Кнопка Изменить
    if request.method == 'POST':
        employee_id = request.POST['edit_button']
        return redirect('editemployee', employee_id=int(employee_id))

    context = {'data': result}
    return render(request, 'main/employee.html', context)

#Форма редактирования сотродника
def editemployee(request, employee_id):
    #Сохранение заготовленных полей
    employeeSurname = request.POST.get('employeeSurname')
    employeeName = request.POST.get('employeeName')
    employeePatronymic = request.POST.get('employeePatronymic')
    genderName = request.POST.get('genderName')
    employeeAge = request.POST.get('employeeAge')
    jobTitleName = request.POST.get('jobTitleName')
    jobtitles = []

    with connection.cursor() as cursor:
        cursor.execute('''SELECT "jobTitle"."jobTitle_id", "jobTitle"."jobTitleName" FROM "jobTitle";''')
        jobtitles = cursor.fetchall()

    #Кнопка Сохранить
    if request.method == 'POST':
        if 'edit_button' not in request.POST:
            name = request.POST.get('name')
            surname = request.POST.get('surname')
            patronymic = request.POST.get('patronymic')
            gender = request.POST.get('gender')
            age = request.POST.get('age')
            jobtitle = request.POST.get('jobtitle')

            with connection.cursor() as cursor:
                query = '''UPDATE public.employee SET "employeeName"=%s, "employeeSurname"=%s, "employeePatronymic"=%s, gender_id=%s, "employeeAge"=%s, "jobTitle_id"=%s WHERE "employee_id" = %s;'''
                cursor.execute(query, [name, surname, patronymic, gender, age, jobtitle, employee_id])
            
            return redirect(reverse('employee'))

    context = {
        'employee_id': employee_id,
        'employeeSurname': employeeSurname,
        'employeeName': employeeName,
        'employeePatronymic': employeePatronymic, 
        'genderName': genderName,
        'employeeAge': employeeAge,
        'jobTitleName': jobTitleName,
        'jobtitles': jobtitles
    }

    return render(request, 'main/editemployee.html', context)

#Форма добавления сотрудника
def addemployee(request):
    message = None
    error_message = None
    jobtitles = []

    with connection.cursor() as cursor:
        cursor.execute('''SELECT "jobTitle"."jobTitle_id", "jobTitle"."jobTitleName" FROM "jobTitle";''')
        jobtitles = cursor.fetchall()

    #Кнопка Сохранить
    if request.method == 'POST':
        name = request.POST.get('name')
        surname = request.POST.get('surname')
        patronymic = request.POST.get('patronymic')
        gender = request.POST.get('gender')
        age = request.POST.get('age')
        jobtitle = request.POST.get('jobtitle')

        #Проверка на заполненность полей
        if not name or not surname or not patronymic or not age:
            error_message = "Пожалуйста, заполните все поля."
            return render(request, 'main/addemployee.html', {'error_message': error_message, 'jobtitles': jobtitles})

        with connection.cursor() as cursor:
            query = '''INSERT INTO employee ("employeeName", "employeeSurname", "employeePatronymic", "gender_id", "employeeAge", "jobTitle_id") VALUES (%s, %s, %s, %s, %s, %s)'''
            cursor.execute(query, [name, surname, patronymic, gender, age, jobtitle])

        message = "Сотрудник успешно добавлен!"
    
    return render(request, 'main/addemployee.html', {'message': message, 'jobtitles': jobtitles})
