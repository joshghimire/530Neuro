function [isResponsive] = testSoundResponsiveness(currCellDFF, windowSizeInFrames)
            preStim = currCellDFF(:, 1:windowSizeInFrames);             % get the dFF measurements from windowSize:stimulus Frame (exclusive)
            postStim = currCellDFF(:, windowSizeInFrames + 1:end);      % get the dFF measurement from stimulus Frame (inclusive): windowSize
            meanPreStim = mean(preStim);
            meanPostStim = mean(postStim);
            [~, p] = ttest(meanPreStim, meanPostStim);
             
            if p < 0.05
                isResponsive = 1;
            else
                isResponsive = 0;
            end
end
