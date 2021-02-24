<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class loginController extends Controller
{
    public function index(Request $request)
    {
        if(!Auth::check() && $request->path() != 'login'){
            return redirect('/login');
        }
        if(!Auth::check() && $request->path() == 'login'){
            return view('welcome');
        }

        $user = Auth::user();
        if($user->userType == 'User'){
            return redirect('/login');
        }
        if($request->path() == 'login'){
            return redirect('/');
        }
        return view('welcome');
    }
    public function logout(){
        Auth::logout();
        return redirect('/login');
    }
    public function adminLogin(Request $request)
    {
        $this->validate($request,[
            'email' => 'required|email',
            'password' => 'required'
        ]);

        if(Auth::attempt(['email' => $request->email, 'password' => $request->password])){
            $user = Auth::user();
            if($user->userType == 'User'){
                Auth::logout();
                return response()->json([
                    'msg' => 'Incorrect login details'
                ],401);
            }
            return response()->json([
                'msg' => 'You are Logged In',
                'user' => $user
            ]);
        }else{
            return response()->json([
                'msg' => 'Incorrect login details'
            ],401);
        }
    }
}
