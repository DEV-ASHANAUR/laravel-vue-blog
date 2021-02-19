<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Tag;

class tagController extends Controller
{
    public function store(Request $request)
    {
        $this->validate($request,[
            'tagName' => 'required'
        ]);
        return Tag::create([
            'tagName' => $request->tagName,
        ]);
    }
    public function getTag()
    {
        return Tag::orderBy('id','desc')->get();
    }
}
