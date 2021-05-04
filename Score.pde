class Score {

  int score, highScore;

  Score() {

    score = 0;
    highScore = 0;
  }

  void increaseScore() {
    score++;
  }
  void checkIfNewHighScore() {
    if (score > highScore) {
      highScore = score;
    }
  }
  void resetScore() {
    score = 0;
  }
  void drawScores(int fontSize, int textColor) {
    textSize(fontSize);
    fill(textColor);
    textAlign(CENTER);
    text("Score: " + score, width * 0.5, height * 0.05 -10);
    text("Highscore: " + highScore, width * 0.75, height * 0.05 -10);
  }
}
