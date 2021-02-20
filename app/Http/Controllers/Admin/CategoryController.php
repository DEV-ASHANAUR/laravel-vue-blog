<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Category;

class CategoryController extends Controller
{
    public function upload(Request $request)
    {
        $picName = time().'.'.$request->file->extension();
        $request->file->move(public_path('uploads/category'),$picName);
        return $picName;
    }
}
