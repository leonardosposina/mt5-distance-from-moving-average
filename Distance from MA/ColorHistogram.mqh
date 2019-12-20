//+------------------------------------------------------------------+
//|                                               ColorHistogram.mqh |
//|                                Copyright 2019, Leonardo Sposina. |
//|           https://www.mql5.com/en/users/leonardo_splinter/seller |
//+------------------------------------------------------------------+

#property copyright "Copyright 2019, Leonardo Sposina."
#property link      "https://www.mql5.com/en/users/leonardo_splinter/seller"
#property version   "1.1"

enum BAR_POSITION { ABOVE, BELOW };

class ColorHistogram {

  private:
  
    double buffer[], colors[];
  
  public:
  
    ColorHistogram(int bufferIndex, int colorIndex);
  
    double getValue(int index);
    void setValue(int index, double value);
    double averageDistance(int index, int period, BAR_POSITION position);

};

ColorHistogram::ColorHistogram(int bufferIndex, int colorIndex) {
  SetIndexBuffer(bufferIndex, this.buffer, INDICATOR_DATA);
  SetIndexBuffer(bufferIndex, this.buffer, INDICATOR_DATA);
  SetIndexBuffer(colorIndex, this.colors, INDICATOR_COLOR_INDEX);
}

double ColorHistogram::getValue(int index) {
  return this.buffer[index];
}

void ColorHistogram::setValue(int index, double value) {
  this.buffer[index] = value;
  this.colors[index] = (value > 0) ? ABOVE : BELOW;
}

double ColorHistogram::averageDistance(
  int index,
  int period,
  BAR_POSITION position
) {

  double result = 0.0;

  if (index > period) {
    double accumulator = 0.0;

    for (int i = index - period; i <= index; i++) {
      if (position == ABOVE) {
        accumulator += (buffer[i] > 0) ? buffer[i] : 0.0;
      } else if (position == BELOW) {
        accumulator += (buffer[i] < 0) ? buffer[i] : 0.0;
      }
    }
    result = accumulator / (double) period;
  }

  return result;
}
