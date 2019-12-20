//+------------------------------------------------------------------+
//|                                                MovingAverage.mqh |
//|                                Copyright 2019, Leonardo Sposina. |
//|           https://www.mql5.com/en/users/leonardo_splinter/seller |
//+------------------------------------------------------------------+

#property copyright "Copyright 2019, Leonardo Sposina."
#property link      "https://www.mql5.com/en/users/leonardo_splinter/seller"
#property version   "1.10"

class MovingAverage {

  private:
  
    int handle;
    double buffer[];
  
  public:
  
    MovingAverage(int bufferIndex, int maPeriod, ENUM_MA_METHOD maMethod);
  
    bool update(int rates);
    double getvalue(int index);

};

MovingAverage::MovingAverage(int bufferIndex, int maPeriod, ENUM_MA_METHOD maMethod) {
  SetIndexBuffer(bufferIndex, this.buffer, INDICATOR_DATA);
  this.handle = iMA(_Symbol, _Period, maPeriod, 0, maMethod, PRICE_CLOSE);
}

bool MovingAverage::update(int rates) {
  return (CopyBuffer(this.handle, 0, 0, rates, this.buffer) > 0);
}

double MovingAverage::getvalue(int index) {
  return this.buffer[index];
}
