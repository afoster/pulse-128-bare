<?php

namespace App\Http\Controllers;

class HelloController extends Controller
{

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response('OK', 200)->header('Content-Type', 'text/plain');
    }
}
