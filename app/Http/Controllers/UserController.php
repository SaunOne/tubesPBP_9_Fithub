<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Exception;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
  public function getUserById($id)
  {
    try {
      $user = User::findOrFail($id);
      return response()->json([
        'user' => $user
      ], 200);
    } catch (Exception $e) {
      return response()->json([
        'message' => 'User not found',
        'error' => $e
      ], 404);
    }
  }

  public function updatePassword(Request $request, $email) {
    try {
        // Find user by email
        $user = User::where('email', $email)->first();

        // Check if the user exists
        if (!$user) {
            return response()->json([
                'message' => 'User not found',
            ], 404);
        }

        // Update user password
        $user->password = Hash::make($request->password);
        $user->save();

        // Return a success response
        return response()->json([
            'message' => 'Password successfully updated',
            'user' => $user,
        ], 200);

    } catch (ModelNotFoundException $e) {
        // Handle specific case where the user is not found
        return response()->json([
            'message' => 'User not found',
            'error' => $e->getMessage(),
        ], 404);

    } catch (Exception $e) {
        // Handle other exceptions
        return response()->json([
            'message' => 'Error updating password',
            'error' => $e->getMessage(),
        ], 500);
    }
}

}
