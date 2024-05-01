import static java.lang.Math.pow;

public class PPMCalculator {

    public static double calculateNewPeriod(double baseFreq, int ppm) {
        // Convert ppm to a decimal multiplier
        double ppmMultiplier = ppm / 1_000_000.0; // 1 million for conversion from ppm to decimal
//        System.out.print(ppmMultiplier);
        // Calculate the value to add (ppm of base_period)
        double ppmValue = baseFreq * ppmMultiplier;

        // Add the ppm value to the base value
        double newFreq = baseFreq - ppmValue;

        return newFreq;
    }

    public static void main(String[] args) {
        double baseFreq = 5; // ns
        int ppm = 100;

        double newFreq = calculateNewPeriod(baseFreq, ppm);

        System.out.println("Base Freq: " + baseFreq + "ns, PPM: " + ppm + ", New Freq: " + newFreq + "ns");
        System.out.println("NEW PERIOD in ns: "+(1/newFreq)+" - NEW PERIOD in ps: "+(1/newFreq)*pow(10,-9)*pow(10,12)+ " - Delay = "+((1/baseFreq)-(1/newFreq)));
    }
}
