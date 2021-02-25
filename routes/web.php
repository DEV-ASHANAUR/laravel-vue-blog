<?php
use App\Http\Middleware\AdminCheck;
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
// Route::post('app/create_tag','testController@index');

Route::get('/','Admin\loginController@index');
Route::get('/logout','Admin\loginController@logout');

Route::any('{slug}', 'Admin\loginController@index');

Route::prefix('app')->middleware([AdminCheck::class])->group(function(){
    //======================admin login=================
    Route::post('/admin_login','Admin\loginController@adminLogin');
    // ========================createUser===============
    Route::get('/get_user_admin','Admin\UserController@getUser');
    Route::post('/create_admin_user','Admin\UserController@store');
    Route::post('/edit_admin_user','Admin\UserController@edit');
    Route::post('/delete_user','Admin\UserController@destroy');
    // =========================tag================
    Route::post('/create_tag','Admin\tagController@store');
    Route::get('/get_tag','Admin\tagController@getTag');
    Route::post('/edit_tag','Admin\tagController@editTag');
    Route::post('/delete_tag','Admin\tagController@deleteTag');
    // =================category====================
    Route::post('/cat_icon','Admin\CategoryController@upload');
    Route::post('/delete_image','Admin\CategoryController@deleteImage');
    Route::post('/create_category','Admin\CategoryController@store');
    Route::get('/get_category','Admin\CategoryController@getCategory');
    Route::post('/delete_editimage','Admin\CategoryController@deleteEditImage');
    Route::post('/edit_category','Admin\CategoryController@editCategory');
    Route::post('/delete_category','Admin\CategoryController@destroy');
    // =====================role======================
    Route::get('/get_role','Admin\RoleController@getRole');
    Route::post('/create_role','Admin\RoleController@store');
    Route::post('/edit_role','Admin\RoleController@edit');
    Route::post('/delete_role','Admin\RoleController@destroy');
});    