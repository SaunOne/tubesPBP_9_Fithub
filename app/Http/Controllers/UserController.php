<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Exception;

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
}
