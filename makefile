# FMKMF_F90 not set: using f90
# FMKMF_SFTAG not set: using f90
# FMKMF_SPATH not set: using . 
# FMKMF_LINKOPTS not set: using no link options 
# Main program is cmc.f90 
# process_fsource called with arg cmc.f90 
# cmc.f90 Uses Module DMCCalculationModule
# Full list of modules in cmc.f90: DMCCalculationModule 
# Uses DMCCalculationModule which is in ./DMCCalculation.f90
# process_fsource called with arg ./DMCCalculation.f90 
# ./DMCCalculation.f90 Uses Module NumberKinds
# ./DMCCalculation.f90 Uses Module OutputWriterModule
# ./DMCCalculation.f90 Uses Module InputReaderModule
# ./DMCCalculation.f90 Uses Module LoggerModule
# ./DMCCalculation.f90 Uses Module EnsembleWalkerModule
# ./DMCCalculation.f90 Uses Module PotentialModule
# Full list of modules in ./DMCCalculation.f90: NumberKinds OutputWriterModule InputReaderModule LoggerModule EnsembleWalkerModule PotentialModule 
# Uses NumberKinds which is in ./NumberKinds.f90
# process_fsource called with arg ./NumberKinds.f90 
# Full list of modules in ./NumberKinds.f90:  
# Uses OutputWriterModule which is in ./OutputWriter.f90
# process_fsource called with arg ./OutputWriter.f90 
# ./OutputWriter.f90 Uses Module NumberKinds
# Full list of modules in ./OutputWriter.f90: NumberKinds 
# Uses NumberKinds which is in ./NumberKinds.f90
# ./NumberKinds.f90 already in list
# Uses InputReaderModule which is in ./InputReader.f90
# process_fsource called with arg ./InputReader.f90 
# ./InputReader.f90 Uses Module NumberKinds
# ./InputReader.f90 Uses Module LoggerModule
# Full list of modules in ./InputReader.f90: NumberKinds LoggerModule 
# Uses NumberKinds which is in ./NumberKinds.f90
# ./NumberKinds.f90 already in list
# Uses LoggerModule which is in ./Logger.f90
# process_fsource called with arg ./Logger.f90 
# ./Logger.f90 Uses Module NumberKinds
# ./Logger.f90 Uses Module OutputWriterModule
# Full list of modules in ./Logger.f90: NumberKinds OutputWriterModule 
# Uses NumberKinds which is in ./NumberKinds.f90
# ./NumberKinds.f90 already in list
# Uses OutputWriterModule which is in ./OutputWriter.f90
# ./OutputWriter.f90 already in list
# Uses LoggerModule which is in ./Logger.f90
# ./Logger.f90 already in list
# Uses EnsembleWalkerModule which is in ./EnsembleWalker.f90
# process_fsource called with arg ./EnsembleWalker.f90 
# ./EnsembleWalker.f90 Uses Module NumberKinds
# ./EnsembleWalker.f90 Uses Module OutputWriterModule
# ./EnsembleWalker.f90 Uses Module LoggerModule
# ./EnsembleWalker.f90 Uses Module PotentialModule
# ./EnsembleWalker.f90 Uses Module ParticleEnsembleModule
# ./EnsembleWalker.f90 Uses Module GaussianDistributorModule
# ./EnsembleWalker.f90 Uses Module HistogramBuilderModule
# Full list of modules in ./EnsembleWalker.f90: NumberKinds OutputWriterModule LoggerModule PotentialModule ParticleEnsembleModule GaussianDistributorModule HistogramBuilderModule 
# Uses NumberKinds which is in ./NumberKinds.f90
# ./NumberKinds.f90 already in list
# Uses OutputWriterModule which is in ./OutputWriter.f90
# ./OutputWriter.f90 already in list
# Uses LoggerModule which is in ./Logger.f90
# ./Logger.f90 already in list
# Uses PotentialModule which is in ./Potential.f90
# process_fsource called with arg ./Potential.f90 
# ./Potential.f90 Uses Module NumberKinds
# ./Potential.f90 Uses Module OutputWriterModule
# ./Potential.f90 Uses Module LoggerModule
# Full list of modules in ./Potential.f90: NumberKinds OutputWriterModule LoggerModule 
# Uses NumberKinds which is in ./NumberKinds.f90
# ./NumberKinds.f90 already in list
# Uses OutputWriterModule which is in ./OutputWriter.f90
# ./OutputWriter.f90 already in list
# Uses LoggerModule which is in ./Logger.f90
# ./Logger.f90 already in list
# Uses ParticleEnsembleModule which is in ./ParticleEnsemble.f90
# process_fsource called with arg ./ParticleEnsemble.f90 
# ./ParticleEnsemble.f90 Uses Module NumberKinds
# ./ParticleEnsemble.f90 Uses Module OutputWriterModule
# ./ParticleEnsemble.f90 Uses Module LoggerModule
# Full list of modules in ./ParticleEnsemble.f90: NumberKinds OutputWriterModule LoggerModule 
# Uses NumberKinds which is in ./NumberKinds.f90
# ./NumberKinds.f90 already in list
# Uses OutputWriterModule which is in ./OutputWriter.f90
# ./OutputWriter.f90 already in list
# Uses LoggerModule which is in ./Logger.f90
# ./Logger.f90 already in list
# Uses GaussianDistributorModule which is in ./GaussianDistributor.f90
# process_fsource called with arg ./GaussianDistributor.f90 
# ./GaussianDistributor.f90 Uses Module NumberKinds
# ./GaussianDistributor.f90 Uses Module OutputWriterModule
# ./GaussianDistributor.f90 Uses Module LoggerModule
# Full list of modules in ./GaussianDistributor.f90: NumberKinds OutputWriterModule LoggerModule 
# Uses NumberKinds which is in ./NumberKinds.f90
# ./NumberKinds.f90 already in list
# Uses OutputWriterModule which is in ./OutputWriter.f90
# ./OutputWriter.f90 already in list
# Uses LoggerModule which is in ./Logger.f90
# ./Logger.f90 already in list
# Uses HistogramBuilderModule which is in ./HistogramBuilder.f90
# process_fsource called with arg ./HistogramBuilder.f90 
# ./HistogramBuilder.f90 Uses Module NumberKinds
# ./HistogramBuilder.f90 Uses Module OutputWriterModule
# ./HistogramBuilder.f90 Uses Module LoggerModule
# Full list of modules in ./HistogramBuilder.f90: NumberKinds OutputWriterModule LoggerModule 
# Uses NumberKinds which is in ./NumberKinds.f90
# ./NumberKinds.f90 already in list
# Uses OutputWriterModule which is in ./OutputWriter.f90
# ./OutputWriter.f90 already in list
# Uses LoggerModule which is in ./Logger.f90
# ./Logger.f90 already in list
# Uses PotentialModule which is in ./Potential.f90
# ./Potential.f90 already in list

# ------------------Macro-Defs---------------------
F90=gfortran

# -------------------End-macro-Defs---------------------------

# Here is the link step 
cmc:NumberKinds.o OutputWriter.o Logger.o InputReader.o Potential.o ParticleEnsemble.o GaussianDistributor.o HistogramBuilder.o EnsembleWalker.o DMCCalculation.o cmc.o 
	 $(F90) -o cmc NumberKinds.o OutputWriter.o Logger.o InputReader.o Potential.o ParticleEnsemble.o GaussianDistributor.o HistogramBuilder.o EnsembleWalker.o DMCCalculation.o cmc.o   

# Here are the compile steps
 
NumberKinds.o:./NumberKinds.f90  
	 $(F90) -c ./NumberKinds.f90 

OutputWriter.o:./OutputWriter.f90 NumberKinds.o 
	 $(F90) -c ./OutputWriter.f90 

Logger.o:./Logger.f90 NumberKinds.o OutputWriter.o 
	 $(F90) -c ./Logger.f90 

InputReader.o:./InputReader.f90 NumberKinds.o Logger.o 
	 $(F90) -c ./InputReader.f90 

Potential.o:./Potential.f90 NumberKinds.o OutputWriter.o Logger.o 
	 $(F90) -c ./Potential.f90 

ParticleEnsemble.o:./ParticleEnsemble.f90 NumberKinds.o OutputWriter.o Logger.o 
	 $(F90) -c ./ParticleEnsemble.f90 

GaussianDistributor.o:./GaussianDistributor.f90 NumberKinds.o OutputWriter.o Logger.o 
	 $(F90) -c ./GaussianDistributor.f90 

HistogramBuilder.o:./HistogramBuilder.f90 NumberKinds.o OutputWriter.o Logger.o 
	 $(F90) -c ./HistogramBuilder.f90 

EnsembleWalker.o:./EnsembleWalker.f90 NumberKinds.o OutputWriter.o Logger.o Potential.o ParticleEnsemble.o GaussianDistributor.o HistogramBuilder.o 
	 $(F90) -c ./EnsembleWalker.f90 

DMCCalculation.o:./DMCCalculation.f90 NumberKinds.o OutputWriter.o InputReader.o Logger.o EnsembleWalker.o Potential.o 
	 $(F90) -c ./DMCCalculation.f90 

cmc.o:cmc.f90 DMCCalculation.o 
	 $(F90) -c cmc.f90 
# This entry allows you to type " make clean " to get rid of
# all object and module files 
clean:
	rm -f -r f_{files,modd}* *.o *.mod *.M *.d V*.inc *.vo \
	V*.f *.dbg album F.err
  
