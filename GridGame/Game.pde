import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  private int player2Life;
  private Dot player;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] food;
  int lifeMax = 100;
  int lifeMin = 0;

  Game(int width, int height, int numberOfEnemies, int numbersOfFood)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(0, 0, width-1, height-1);
    enemies = new Dot[numberOfEnemies];
    //food skal have en random spawn værdi
    food = new Dot[numbersOfFood];

    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    for (int i = 0; i < numbersOfFood; ++i)
    {
      food[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    this.playerLife = 100;
    this.player2Life = 100;
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }
  public int getPlayer2Life()
  {
    return player2Life;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }

  public void update()
  {
    updatePlayer();
    updatePlayer2();
    updateEnemies();
    updateEnemiesP2();
    checkForCollisions();
    checkForFoodCollisions();
    checkForCollisions2();
    checkForFoodCollisions2();
    clearBoard();
    populateBoard();
    updateFood();
    updateFoodp2();
    
  }



  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer()
  {
    //Update player
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }
  private void updatePlayer2()
  {    
    //Update playerTwo
    if (keys.p1Down() && !keys.p2Down())
    {
      player2.moveUp();
    }
    if (keys.p3Down() && !keys.p4Down())
    {
      player2.moveLeft();
    }
    if (keys.p2Down() && !keys.p1Down())
    {
      player2.moveDown();
    }
    if (keys.p4Down() && !keys.p3Down())
    {
      player2.moveRight();
    }
  }


  //Enemies movement
  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }
  private void updateEnemiesP2()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player2.getX() - enemies[i].getX();
        int dy = player2.getY() - enemies[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }


  //food movement
  private void updateFoodp2()
  {
    for (int i = 0; i < food.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player.getX() - food[i].getX();
        int dy = player.getY() - food[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            food[i].moveLeft();
          } else
          {
            //Player is to the left
            food[i].moveRight();
          }
        } else if (dy > 0)
        {
          //Player is down;
          food[i].moveUp();
        } else
        {//Player is up;
          food[i].moveDown();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          food[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          food[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          food[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }
  private void updateFood()
  {
    for (int i = 0; i < food.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player2.getX() - food[i].getX();
        int dy = player2.getY() - food[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            food[i].moveLeft();
          } else
          {
            //Player is to the left
            food[i].moveRight();
          }
        } else if (dy > 0)
        {
          //Player is down;
          food[i].moveUp();
        } else
        {//Player is up;
          food[i].moveDown();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          food[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          food[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          food[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }
  private void populateBoard()
  {
    //Insert player
    board[player.getX()][player.getY()] = 1;
    board[player2.getX()][player2.getY()] = 4;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    for (int i = 0; i < food.length; ++i)
    {
      board[food[i].getX()][food[i].getY()] = 3;
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision

        if (playerLife > lifeMin) {
          //We have a collision
          --playerLife;
        }
      }
    }
  }

  private void checkForCollisions2()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY())
      {
        //We have a collision

        if (player2Life > lifeMin) {
          //We have a collision
          --player2Life;
        }
      }
    }
  }

  private void checkForFoodCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < food.length; ++i)
    {
      if (food[i].getX() == player.getX() && food[i].getY() == player.getY())
      {
        if (playerLife < lifeMax) {
          //We have a collision
          ++playerLife;
          food[i].x = (int)random(0, 25);
          food[i].y = (int)random(0, 25);
        }
      }
    }
  }
  private void checkForFoodCollisions2()
  {
    //Check enemy collisions
    for (int i = 0; i < food.length; ++i)
    {
      if (food[i].getX() == player2.getX() && food[i].getY() == player2.getY())
      {
        if (player2Life < lifeMax) {
          //We have a collision
          ++player2Life;
          
        }
      }
    }
  }

}
