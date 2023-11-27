<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Schedule;
use Illuminate\Http\Request;

class ScheduleController extends Controller
{
     public function index()
    {
        try {
            
            $schedule = Schedule::select('schedules.*')->where('id_user', auth()->id())->get();
            return response()->json([
                'status' => true,
                'message' => 'Berhasil ambil data',
                'data' => $schedule
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => $e->getMessage(),
                'data' => []
            ], 400);
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $request['id_user'] = auth()->id();
            $schedule = Schedule::create($request->all());
            return response()->json([
                'status' => true,
                'message' => 'Berhasil Insert Data',
                'data' => $schedule
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => $e->getMessage(),
                'data' => []
            ]);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        try {
            $schedule = Schedule::find($id);

            if (!$schedule) throw new \Exception("Schedule tidak ditemukan");

            return response()->json([
                'status' => true,
                'message' => 'Berhasil ambil Data',
                'data' => $schedule
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => $e->getMessage(),
                'data' => []
            ], 400);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        try {
            $schedule = Schedule::find($id);

            if (!$schedule) throw new \Exception('Schedule tidak ditemukan');

            $schedule->update($request->all());

            return response()->json([
                'status' => true,
                'message' => 'Berhasil ambil Data',
                'data' => $schedule
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => $e->getMessage(),
                'data' => []
            ], 400);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        try{
            $schedule = Schedule::find($id);

            if(!$schedule) throw new \Exception('Schedule tidak ditemukan');

            $schedule->delete();

            return response()->json([
                'status' => true,
                'message' => 'Berhasil ambil Data',
                'data' => $schedule
            ], 200);
        }catch(\Exception $e){
            return response()->json([
                'status' => false,
                'message' => $e->getMessage(),
                'data' => []
            ], 400);
        }
    }
}
