<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\RoleRequest;
use App\Role;
use Illuminate\Http\Request;

class RoleController extends Controller
{
    public function getRole(){
        return Role::orderBy('id','desc')->get();
    }
    public function store(Request $request){
        $this->validate($request,[
            'roleName' => 'required|unique:roles',
        ]);
        return Role::create([
            'roleName' => $request->roleName,
        ]);
    }
    public function edit(RoleRequest $request){
        return Role::where('id',$request->id)->update([
            'roleName' => $request->roleName,
        ]);
    }
    public function destroy(Request $request)
    {
        $role = Role::find($request->id);
        return $role->delete();
    }
    public function assignRole(Request $request){
        $this->validate($request,[
            'permission' => 'required',
            'id' => 'required'
        ]);
        return Role::where('id',$request->id)->update([
            'permission' => $request->permission,
        ]);

    }
}
