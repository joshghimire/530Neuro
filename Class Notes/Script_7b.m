%%
load SampleLFPdata.mat

soundDurationInS=2;
sampleRate=25000;
sampleRange=1:sampleRate*soundDurationInS;
timevec=1/sampleRate:1/sampleRate:soundDurationInS;
frequencyComponent1=2;
frequencyComponent2=10;
frequencyComponent3=100;
sig1=sin(2*pi/sampleRate*frequencyComponent1*(sampleRange));
sig2=sin(2*pi/sampleRate*frequencyComponent2*(sampleRange));
sig3=sin(2*pi/sampleRate*frequencyComponent3*(sampleRange));

fullSignal=sig1+sig2+sig3;
%%
figure;
plot(timevec,fullSignal)
xlabel('Time (s)')
%%
figure;
plot(timevec,fullSignal)
xlabel('Time (s)')
hold on
plot(timevec,sig1,'k','LineWidth',2)
%%
plot(timevec,sig2,'r','LineWidth',2)
%%
plot(timevec,sig3,'g','LineWidth',2)

%% "Filtering"
figure;
lowSig=sin(2*pi/sampleRate*frequencyComponent1*(sampleRange));
highSig=sin(2*pi/sampleRate*frequencyComponent3*(sampleRange));
figure;
subplot(3,1,1)
plot(timevec,fullSignal)
ylim([-4 4])
title('Original')
xlabel('Time (s)')

subplot(3,1,2)
plot(timevec,lowSig)
ylim([-4 4])
title('"Low pass"')
xlabel('Time (s)')

subplot(3,1,3)
plot(timevec,highSig)
ylim([-4 4])
title('"High pass"')
xlabel('Time (s)')

%% Changes in time of oscillatory power 
newSig=lowSig;
newSig(20000:30000)=newSig(20000:30000)+0.2*highSig(20000:30000);
figure;
plot(timevec,newSig)
xlabel('Time (s)')

%% 
highfiltered=bandpass(newSig,[80 120],sampleRate);
highpower=envelope(abs(highfiltered),2000,'rms');
figure;
subplot(2,1,1)
plot(timevec,newSig)
ylim([-2.5 2.5])

xlabel('Time (s)')

subplot(2,1,2)
plot(timevec,highpower,'k','linewidt',2)
ylim([0 0.2])
xlabel('Time (s)')
ylabel('High freq power')


%% To neural data!
% LFP recordings from mouse CA1 region of the hippocampus during non-REM
% sleep

load('SampleLFPdata.mat')
figure;
plot(s_times,s)
xlabel('Time (s)')
%% filtering in the ripple band
% also mention designfilt, filterDesigner
figure;
bandpass(s,[150 250],LFPsamplerate);
%% 
figure;
bandpass(s,[150 250],LFPsamplerate,'steepness',0.98);


%% aside: high-pass and low-pass filtering
freqcutoff=50;
highfiltered=highpass(s,freqcutoff,LFPsamplerate,'steepness',0.98);
lowfiltered=lowpass(s,freqcutoff,LFPsamplerate,'steepness',0.98);
figure;
plot(s_times,s,'k');
hold on
plot(s_times,highfiltered,'r')
plot(s_times,lowfiltered,'b')
xlabel('Time (s)')



%% quantifying ongoing ripple power
ripplefiltered=bandpass(s,[150 250],LFPsamplerate,'steepness',0.98);
ripplepower=envelope(abs(ripplefiltered),round(LFPsamplerate/10),'rms');   
% ^envelop of the absolute value of the ripple filtered signal; what is roughly the timescale that you want the envlope to be. Here we have
% LFPsamplerate (how many samples we have)/10. So 10th of a second, which works for a ripple because its between 1/10 to 1/20 of a second.
% It's not an area under the curve necessary, but the root mean square. Clarify this? He said it's like the energy.
% as the round(LFPsamplerate/10) argument increases, the bump/envelop used is larger. 
% if you think of the ripple as a peak, increasing the ^ above would increase the peak of the signal??
% Where in the signal do we have increases in ripple power. 
figure;
plot(s_times,s,'b');
hold on;
plot(s_times,ripplefiltered,'r');
plot(s_times,ripplepower,'k','linewidth',3)
xlabel('Time (s)')
legend({'Original signal', 'Ripple-filtered signal','Ripple power'})
%% Finding candidate ripples
% using your good old findOnsetsOfBigIncreases!
candidateRipplesInds=findOnsetsOfBigIncreases(ripplepower);
candidateRipplesMagnitude=ripplepower(candidateRipplesInds);
plot(s_times(candidateRipplesInds),candidateRipplesMagnitude,'mo','markerfacecolor','m')

%% spectrogram
%%
figure;pspectrum(s,LFPsamplerate,'FrequencyLimits',[0 300],'spectrogram')
%% spectrogram with outputs. Tp gives you time vector, fp -> y axis, sP is power
[sP fP tP]=pspectrum(s,LFPsamplerate,'FrequencyLimits',[0 300],'spectrogram');
figure;
imagesc(tP,fP,10*log10(sP));    %Need to apply the 10log10sp. Only shows extreme values if you don't apply it.
set(gca,'YDir','normal');
xlabel('Time (s)')
ylabel('Frequency (Hz)')
%% spectrogram with time series
figure;

h1=subplot(2,1,1)
plot(s_times,s,'b');hold on;plot(s_times,ripplefiltered,'r');plot(s_times,ripplepower,'k','linewidth',3)
plot(s_times(candidateRipplesInds),candidateRipplesMagnitude,'mo','markerfacecolor','m')

h2=subplot(2,1,2)
imagesc(tP,fP,10*log10(sP));
set(gca,'YDir','normal');
linkaxes([h1 h2],'x');          % links the axes of two plots. Zomming into the axes of one plot zooms into the axes of the second plot. 'x' argument links both the x values. 
%% aside: using 'spectrogram' function
% IMAGINE SPECTROGRAM AS A PLOT WHERE THE "Camels hump" Is coming out towards you. Look at last fiugre in Lect4.pptx
figure;spectrogram(s,round(LFPsamplerate/5),round(LFPsamplerate/10),0:300,LFPsamplerate,'yaxis')

[~,freqs,timevec,S1]=spectrogram(s,round(LFPsamplerate/5),round(LFPsamplerate/6),0:300,LFPsamplerate,'yaxis');
figure;
h1=subplot(2,1,1)
plot(s_times,s,'b');hold on;plot(s_times,ripplefiltered,'r');plot(s_times,ripplepower,'k','linewidth',3)
h2=subplot(2,1,2)
imagesc(timevec,freqs,10*log10(abs(S1)));
set(gca,'YDir','normal');
caxis([-180 -80])
ylim([100 300])
linkaxes([h1 h2],'x');
%% power spectrum
figure;
pspectrum(s,LFPsamplerate,'FrequencyLimits',[0 300])

%pwelch(double(s),double(round(LFPsamplerate/5)),double(round(LFPsamplerate/6)),1:300,round(LFPsamplerate));

%% power spectrums of periods with high and low ripple power
sRip=s(ripplepower>mean(ripplepower)+1*std(ripplepower));
sNoRip=s(ripplepower<(mean(ripplepower)+1*std(ripplepower)));

figure;
pspectrum(sNoRip,LFPsamplerate,'FrequencyLimits',[0 300])
hold on
pspectrum(sRip,LFPsamplerate,'FrequencyLimits',[0 300])


%% Application to sounds
% The dog sound is in the canvas data folder. 
[bark SOUNDsamplerate]=audioread('/Users/gid/Dropbox (University of Michigan)/from_box/LabStartup/Teaching/NeuroanalyticsW2024/Data/Dachshund.wav');
w_times=1/SOUNDsamplerate:1/SOUNDsamplerate:length(bark)/SOUNDsamplerate;
figure;
plot(w_times,bark)
xlabel('Time (s)')
%%
sound(bark,SOUNDsamplerate)
%% spectrogram and power spectrum
figure;
subplot(2,1,1)
pspectrum(bark,SOUNDsamplerate,'FrequencyLimits',[0 SOUNDsamplerate/2],'spectrogram')
caxis([-140 -10])
subplot(2,1,2)
pspectrum(bark,SOUNDsamplerate,'FrequencyLimits',[0 SOUNDsamplerate/2])

%% Filtering for the central freqs
bark_centralfreqs=bandpass(bark,[500 2000],SOUNDsamplerate);
figure;
subplot(2,1,1)
pspectrum(bark_centralfreqs,SOUNDsamplerate,'FrequencyLimits',[0 SOUNDsamplerate/2],'spectrogram')
caxis([-140 -10])
subplot(2,1,2)
pspectrum(bark_centralfreqs,SOUNDsamplerate,'FrequencyLimits',[0 SOUNDsamplerate/2])

%%
sound(bark_centralfreqs,SOUNDsamplerate)
%%
bark_highfreqs=bandpass(bark,[2000 10000],SOUNDsamplerate);
figure;
subplot(2,1,1)
pspectrum(bark_highfreqs,SOUNDsamplerate,'FrequencyLimits',[0 SOUNDsamplerate/2],'spectrogram')
caxis([-140 -10])
subplot(2,1,2)
pspectrum(bark_highfreqs,SOUNDsamplerate,'FrequencyLimits',[0 SOUNDsamplerate/2])
%%
sound(bark_highfreqs,SOUNDsamplerate)
%%
sound(bark,SOUNDsamplerate)
pause(1)
sound(bark_centralfreqs,SOUNDsamplerate)
pause(1)
sound(bark_highfreqs,SOUNDsamplerate)
