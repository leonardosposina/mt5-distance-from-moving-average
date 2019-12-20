//+------------------------------------------------------------------+
//|                                                 AverageLevel.mqh |
//|                                Copyright 2019, Leonardo Sposina. |
//|           https://www.mql5.com/en/users/leonardo_splinter/seller |
//+------------------------------------------------------------------+

#property copyright "Copyright 2019, Leonardo Sposina."
#property link      "https://www.mql5.com/en/users/leonardo_splinter/seller"
#property version   "1.1"

class AverageLevel {

  private:
  
    int index;
    int barCount;
    double barSum;
  
    void resetData(void);
  
  public:
  
    AverageLevel(int levelIndex, string title);
  
    void push(double bar);
    void calculate(void);

};

AverageLevel::AverageLevel(int levelIndex, string title) {
  this.index = levelIndex;
  this.resetData();

  IndicatorSetString(INDICATOR_LEVELTEXT, this.index, title);
}

void AverageLevel::push(double bar) {
  this.barSum += bar;
  this.barCount++;
}

void AverageLevel::calculate(void) {
  double divider = this.barCount + 1;
  double result = this.barSum / divider;
  this.resetData();

  IndicatorSetDouble(INDICATOR_LEVELVALUE, this.index, result);
}

void AverageLevel::resetData(void) {
  this.barSum = 0.0;
  this.barCount = 0;
}
