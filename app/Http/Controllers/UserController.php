<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Exception;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function getUserById($id)
    {
       try{
              $user = User::findOrFail($id);
              return response()->json([
                'user' => $user
              ], 200);
       }catch(Exception $e){
              return response()->json([
                'message' => 'User not found',
                'error' => $e
              ], 404);
       }
    }

    public function getUserByEmail($email)
    {
       try{
              $user = User::where('email', $email)->firstOrFail();
              return response()->json([
                'user' => $user
              ], 200);
       }catch(Exception $e){
              return response()->json([
                'message' => 'User not found',
                'error' => $e
              ], 404);
       }
    }


    public function ResetPassword(Request $request, $email)
    {

        $request->only('password');
        $user = User::where('email', $email)->firstOrFail();

        if(Hash::check($request->password, $user->password)){
            return response()->json([
                'message' => 'Password cannot be the same as the old one'
            ], 401);
        }

        try{
            $user->update([
                'password' => Hash::make($request->password)
            ]);

            return response()->json([
                'message' => 'success',
                'user' => $user
            ], 201);
        }catch(Exception $e){
            return response()->json([
                'message' => 'failed',
                'error' => $e
            ],400);
        }

    }



}
