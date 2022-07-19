<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\RegisterType;
use Doctrine\DBAL\Exception;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\EntityManagerInterface;
use Monolog\Logger;
use Psr\Log\LoggerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;


class RegisterController extends AbstractController
{

    /**
     * @var EntityManagerInterface
     */
    private $entityManager;

    /**
     * @var Logger
     */
    private $logger;

    /**
     * @param EntityManagerInterface $entityManager
     * @param Logger $logger
     */
    public function __construct(EntityManagerInterface $entityManager, LoggerInterface $logger)
    {
        $this->entityManager = $entityManager;
        $this->logger = $logger;
    }

    /**
     * @Route("/inscription", name="app_register")
     */
    public function registerAction(Request $request): Response
    {
        $user = new User();
        $form = $this->createForm(RegisterType::class, $user);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $user = $form->getData();

            try {
                $this->entityManager->persist($user);
                $this->entityManager->flush();
            } catch (Exception $exception) {
                $this->logger->error("[REGISTER] " . $exception->getMessage());
            }
        }

        return $this->render('register/register_form.html.twig', [
            'form' => $form->createView()
        ]);
    }
}
