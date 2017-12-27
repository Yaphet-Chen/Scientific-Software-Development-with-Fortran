!D.1. cmc.f90 

!****************************************************************************
!
!  PROGRAM: CMC
!
!  PURPOSE:  Main program of Confusion Monte Carlo.
!
!****************************************************************************

program CMC
    use DMCCalculationModule
    implicit none
    type (DMCCalculation)                                       :: dmcCalc
    call New(dmcCalc)
    call Run(dmcCalc)
    call Delete(dmcCalc)
end program

