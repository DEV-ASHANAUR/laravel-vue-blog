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
        return User::orderBy('id','desc')->get();
    }
    public function store(Request $request){
        $this->validate($request,[
            'fullName' => 'required|min:3',
            'email' => 'required|email|unique:users',
            'userType' => 'required',
            'password' => 'required|confirmed|min:8',
        ]);
        $password = bcrypt($request->password);
        $user = User::create([
            'fullName' => $request->fullName,
            'email' => $request->email,
            'userType' => $request->userType,
            'password' => $password,
        ]);
        return $user;
    }
    public function edit(UserRequest $request)
    {
        $user = User::find($request->id);
        $user->fullName = $request->fullName;
        $user->email = $request->email;
        $user->userType = $request->userType;
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
