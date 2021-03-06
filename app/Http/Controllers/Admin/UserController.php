<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\UserRequest;
use App\User;

class UserController extends Controller
{
    public function getUser()
    {
        return User::with('role')->orderBy('id','desc')->get();
    }
    public function store(Request $request){
        $this->validate($request,[
            'fullName' => 'required|min:3',
            'email' => 'required|email|unique:users',
            'role_id' => 'required',
            'password' => 'required|confirmed|min:6',
        ]);
        $password = bcrypt($request->password);
        $user = User::create([
            'fullName' => $request->fullName,
            'email' => $request->email,
            'role_id' => $request->role_id,
            'password' => $password,
        ]);
        $get_user =  User::where('id',$user->id)->with('role')->first();
        return response()->json([
            'user' => $get_user,
        ],201);
    }
    public function edit(UserRequest $request)
    {
        $user = User::find($request->id);
        $user->fullName = $request->fullName;
        $user->email = $request->email;
        $user->role_id = $request->role_id;
        return $user->save();
    }
    public function destroy(Request $request)
    {
        $this->validate($request,[
            'id' => 'required'
        ]);
        $user = User::find($request->id);
        return $user->delete();
    }
}
