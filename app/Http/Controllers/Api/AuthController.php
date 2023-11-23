<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Exception;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
class AuthController extends Controller
{
    public function register(Request $request){
        $validator = Validator::make($request->all(), [
            'fullname' => 'required|string',
            'username' => 'required|string',
            'password' => 'required|string',
            'email' => 'required|string',
            'birthdate' => 'required|string',
            'gender' => 'required|string',
        ]);

        try{
            $user = User::create([
                'username'=> $request->username,
                'fullname'=> $request->fullname,
                'email'=> $request->email,
                'password'=> Hash::make($request->password),
                'gender' => $request->gender,
                'birthdate' => $request->birthdate,
            ]);

            return response()->json([
                'message' => 'success',
                'user' => $user
            ], 201);

        }catch(Exception $e){
            return response()->json([
                'message' => 'failed registration',
                'error' => $e
            ], 409);
        }
    }

    public function login(Request $request){

        if(!Auth::attempt($request->only('email', 'password'))){
            return response()->json([
                'message' => 'Invalid Login'
            ], 401);
        }

       try{

        $user = User::where('email', $request->email)->firstOrFail();

        if(!Hash::check($request->password, $user->password)){
            return response()->json([
                'message' => 'Password mismatch',
            ], 401);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message'=> 'Login Success',
            'data' => $user,
            'access_token' => $token,
            'token_type' => 'Bearer',
        ]);

       }catch (Exception $e){
        return response()->json([
            'message' => 'Login failed',
            'error' => $e
        ], 409);
       }

    }

    public function getAllUser(){
        try{
            $users = User::all();
            return response()->json([
                'message' => 'Get all user success',
                'data' => $users
            ]);
        }catch(Exception $e){
            return response()->json([
                'message' => 'Get all user failed',
                'error' => $e
            ], 409);
        }
    }
}
