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

Route::post('app/create_tag','Admin\tagController@store');
Route::get('app/get_tag','Admin\tagController@getTag');
Route::post('app/edit_tag','Admin\tagController@editTag');
Route::post('app/delete_tag','Admin\tagController@deleteTag');
// =================category====================
Route::post('app/cat_icon','Admin\CategoryController@upload');
Route::post('app/delete_image','Admin\CategoryController@deleteImage');
Route::post('app/create_category','Admin\CategoryController@store');
Route::get('app/get_category','Admin\CategoryController@getCategory');

