<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::post('app/create_tag','testController@index');

Route::get('/', function () {
    return view('welcome');
});

Route::any('{slug}', function() {
    return view('welcome');
});
// ========================createUser===============
Route::get('app/get_user_admin','Admin\UserController@getUser');
Route::post('app/create_admin_user','Admin\UserController@store');
Route::post('app/edit_admin_user','Admin\UserController@edit');
Route::post('app/delete_user','Admin\UserController@destroy');
// =========================tag================
Route::post('app/create_tag','Admin\tagController@store');
Route::get('app/get_tag','Admin\tagController@getTag');
Route::post('app/edit_tag','Admin\tagController@editTag');
Route::post('app/delete_tag','Admin\tagController@deleteTag');
// =================category====================
Route::post('app/cat_icon','Admin\CategoryController@upload');
Route::post('app/delete_image','Admin\CategoryController@deleteImage');
Route::post('app/create_category','Admin\CategoryController@store');
Route::get('app/get_category','Admin\CategoryController@getCategory');
Route::post('app/delete_editimage','Admin\CategoryController@deleteEditImage');
Route::post('app/edit_category','Admin\CategoryController@editCategory');
Route::post('app/delete_category','Admin\CategoryController@destroy');