<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ScheduleController;
use App\Http\Controllers\UserController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::put('/update_password/{email}',[UserController::class,'updatePassword']);
Route::put('/userReset/{email}', [UserController::class, 'ResetPassword']);

Route::group(['middleware' => ['auth:sanctum']], function () {
    Route::get('/user/{id}', [UserController::class, 'getUserById']);
    Route::put('/update/{id}', [UserController::class, 'updateProfile']);

    Route::get('/schedule',[ScheduleController::class,'index']);
    Route::post('/schedule',[ScheduleController::class,'store']);

    Route::get('/schedule/{id}', [ScheduleController::class, 'show']);
    Route::put('/schedule/{id}', [ScheduleController::class, 'update']);
    Route::delete('/schedule/{id}', [ScheduleController::class, 'destroy']);
});
