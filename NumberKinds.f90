!D.8. NumberKinds.f90
module NumberKinds
    implicit none
    
    integer, parameter                                                  :: KREAL = kind(0.d0)
    integer, parameter                                                  :: KINT = kind(1)

end module NumberKinds