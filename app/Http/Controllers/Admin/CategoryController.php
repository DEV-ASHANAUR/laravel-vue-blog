<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\CategoryRequest;
use App\Category;

class CategoryController extends Controller
{
    public function getCategory()
    {
        return Category::orderBy('id','desc')->get();
    }
    public function upload(Request $request)
    {
        $this->validate($request,[
            'file' => 'required|mimes:jpeg,jpg,png'
        ]);
        $picName = time().'.'.$request->file->extension();
        $request->file->move(public_path('uploads/category'),$picName);
        return $picName;
    }
    public function deleteImage(Request $request)
    {
        $fileName = $request->imageName;
        $filePath = public_path().'/uploads/category/'.$fileName;
        if(file_exists($filePath)){
            @unlink($filePath);
        }
        return 'remove';
    }
    public function deleteEditImage(Request $request)
    {
        $fileName = $request->imageName;
        $filePath = public_path().$fileName;
        if(file_exists($filePath)){
            @unlink($filePath);
        }
        return 'remove';
    }
    public function store(Request $request)
    {
        $this->validate($request,[
            'categoryName' => 'required|unique:categories',
            'iconImage' => 'required',
        ]);
        return Category::create([
            'categoryName' => $request->categoryName,
            'iconImage' => $request->iconImage
        ]);
    }
    public function editCategory(CategoryRequest $request)
    {
        return Category::where('id',$request->id)->update([
            'categoryName' => $request->categoryName,
            'iconImage' => $request->iconImage
        ]);
    }
    public function destroy(Request $request)
    {
        $category = Category::find($request->id);
        if($category->delete()){
            $fileName = $request->iconImage;
            $filePath = public_path().$fileName;
            if(file_exists($filePath)){
                @unlink($filePath);
            }
        }
        return response()->json('success');
    }
}
