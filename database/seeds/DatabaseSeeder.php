<?php

use Illuminate\Database\Seeder;
use App\User;
class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        User::create([
            'fullName' => 'Ashanur',
            'email' => 'ashanour009@gmail.com',
            'password' => bcrypt('12345678'),
            'role_id' => 1
        ]);
    }
}
