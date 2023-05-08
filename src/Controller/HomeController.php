<?php

declare(strict_types=1);

namespace App\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
class HomeController
{
    #[Route('/', name: 'home')]
    public function home(): Response
    {
        return new Response('My beautiful homepage');
    }
}