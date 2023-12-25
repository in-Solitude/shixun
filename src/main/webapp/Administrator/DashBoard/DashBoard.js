// 获取按钮元素
let btnHome = document.querySelector('.btn-home');
let btnTeachers = document.querySelector('.btn-teachers');
let btnStudents = document.querySelector('.btn-students');
let btnData = document.querySelector('.btn-data');
let btnLogs = document.querySelector('.btn-logs');
let btnLogout = document.querySelector('.btn-logout');
let btnAddTeacher = document.querySelector('.btn-add-teacher');
let btnEditTeacher = document.querySelector('.btn-edit-teacher');
let btnDeleteTeacher = document.querySelector('.btn-delete-teacher');
let btnSearchTeachers = document.querySelector('.btn-search-teachers');
let btnAddStudent = document.querySelector('.btn-add-student');
let btnEditStudent = document.querySelector('.btn-edit-student');
let btnDeleteStudent = document.querySelector('.btn-delete-student');
let btnSearchStudents = document.querySelector('.btn-search-students');
let btnImportTeachers = document.querySelector('.btn-import-teachers');
let btnImportStudents = document.querySelector('.btn-import-students');
let btnExportTeachers = document.querySelector('.btn-export-teachers');
let btnExportStudents = document.querySelector('.btn-export-students');
let btnViewLogs = document.querySelector('.btn-view-logs');
let btnSearchLogs = document.querySelector('.btn-search-logs');

// 给按钮添加点击事件处理程序//qwe
btnHome.addEventListener('click', function() {
    window.location.href = 'index.jsp';
});

btnTeachers.addEventListener('click', function() {
    window.location.href = 'teachers.html';
});

btnStudents.addEventListener('click', function() {
    window.location.href = 'students.html';
});

btnData.addEventListener('click', function() {
    window.location.href = 'data-import-export.html';
});

btnLogs.addEventListener('click', function() {
    window.location.href = 'login-logs.html';
});

btnLogout.addEventListener('click', function() {
    window.location.href = 'logout.html';
});

btnAddTeacher.addEventListener('click', function() {
    window.location.href = 'add-teacher.html';
});

btnEditTeacher.addEventListener('click', function() {
    window.location.href = 'edit-teacher.html';
});

btnDeleteTeacher.addEventListener('click', function() {
    window.location.href = 'delete-teacher.html';
});

btnSearchTeachers.addEventListener('click', function() {
    window.location.href = 'search-teachers.html';
});

btnAddStudent.addEventListener('click', function() {
    window.location.href = 'add-student.html';
});

btnEditStudent.addEventListener('click', function() {
    window.location.href = 'edit-student.html';
});

btnDeleteStudent.addEventListener('click', function() {
    window.location.href = 'delete-student.html';
});

btnSearchStudents.addEventListener('click', function() {
    window.location.href = 'search-students.html';
});

btnImportTeachers.addEventListener('click', function() {
    window.location.href = 'import-teachers.html';
});

btnImportStudents.addEventListener('click', function() {
    window.location.href = 'import-students.html';
});

btnExportTeachers.addEventListener('click', function() {
    window.location.href = 'export-teachers.html';
});

btnExportStudents.addEventListener('click', function() {
    window.location.href = 'export-students.html';
});

btnViewLogs.addEventListener('click', function() {
    window.location.href = 'view-logs.html';
});

btnSearchLogs.addEventListener('click', function() {
    window.location.href = 'search-logs.html';
});
