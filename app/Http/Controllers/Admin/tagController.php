<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\TagRequest;
use App\Tag;

class tagController extends Controller
{    
    /**
     * getTag()
     *
     * @return void
     */
    public function getTag()
    {
        return Tag::orderBy('id','desc')->get();
    }    
    /**
     * store() tag store
     *
     * @param  mixed $request
     * @return void
     */
    public function store(Request $request)
    {
        $this->validate($request,[
            'tagName' => 'required|unique:tags',
        ]);
        return Tag::create([
            'tagName' => $request->tagName,
        ]);
    }    
    /**
     * editTag() tag edit
     *
     * @param  mixed $request
     * @return void
     */
    public function editTag(TagRequest $request)
    {
        return Tag::where('id',$request->id)->update([
            'tagName' => $request->tagName
        ]);
    }
    public function deleteTag(Request $request)
    {
        $this->validate($request,[
            'id' => 'required'
        ]);
        return Tag::where('id',$request->id)->delete();
    }
    
}
