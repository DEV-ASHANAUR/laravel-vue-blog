<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Not Found</title>
    <style>
        .not-found {
            /* background-color: #282c34; */
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-size: calc(10px + 2vmin);
            text-transform: uppercase;
            text-shadow: 1px -1px black;
            padding: 10px 10px;
            color: purple;
            /* color: white; */
        }
        .not-found h1{

        }
        .not-found a{
            
        }
    </style>
</head>
<body>
    <div class="not-found">
        <h1>You Don't Have Permission!</h1>
        <a href="{{ url('/login') }}"> Back Home </a>
    </div>
    
</body>
</html>