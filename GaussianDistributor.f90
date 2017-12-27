!D.4. GaussianDistributor.f90
module GaussianDistributorModule
    use NumberKinds
    use OutputWriterModule
    use LoggerModule
    implicit none

    private
    public GaussianDistributor
    public New, Delete, assignment(=), OutputProperties
    public GetStandardDeviation, GenerateRandomValue
    save

    type GaussianDistributor
        private
        real(KREAL)                                                         :: standardDeviation
    end type GaussianDistributor

    ! Overloaded procedure interfaces
    interface New
        module procedure NewPrivate, NewCopyPrivate
    end interface New

    interface Delete
        module procedure DeletePrivate
    end interface Delete
    
    interface assignment(=)
        module procedure AssignPrivate
    end interface Assignment(=)
    
    interface OutputProperties
        module procedure OutputPropertiesPrivate
    end interface OutputProperties
    
    ! Logging
    type (Logger)                                                           :: log
    integer(KINT), parameter                                                :: LOGGING_LEVEL = WARNING_LOGGING_LEVEL

contains

    ! ------------------------
    ! Logging.
    ! ------------------------
    subroutine InitLogger()
        ! This routine is called from the constructor to initialize the Logger.
        logical, save :: loggerInitialized = .false.
        if ( .not. loggerInitialized ) then
            call New(log, LOGGING_LEVEL)
            loggerInitialized = .true.
        end if
    end subroutine InitLogger

    ! ------------------------
    ! Standard ADT Methods. Construction, Destruction, Copying, and Assignment.
    ! ------------------------
    subroutine NewPrivate(self, standardDeviation)
        type (GaussianDistributor), intent(out)                             :: self
        real(KREAL), intent(in)                                             :: standardDeviation
        self%standardDeviation = standardDeviation
        call InitLogger
    end subroutine NewPrivate

    subroutine NewCopyPrivate(self, other)
        type (GaussianDistributor), intent(out)                             :: self
        type (GaussianDistributor), intent(in)                              :: other
        self%standardDeviation = other%standardDeviation
    end subroutine NewCopyPrivate
    
    subroutine DeletePrivate(self)
        type (GaussianDistributor), intent(inout)                           :: self
    end subroutine DeletePrivate
    
    subroutine AssignPrivate(self, other)
        type (GaussianDistributor), intent(inout)                           :: self
        type (GaussianDistributor), intent(in)                              :: other
        self%standardDeviation = other%standardDeviation
    end subroutine AssignPrivate

    ! ------------------------
    ! Accessors.
    ! ------------------------
    subroutine SetStandardDeviation(self, standardDeviation)
        type (GaussianDistributor), intent(inout)                           :: self
        real(KREAL), intent(in)                                             :: standardDeviation
        self%standardDeviation = standardDeviation
    end subroutine SetStandardDeviation

    function GetStandardDeviation(self)
        type (GaussianDistributor), intent(in)                              :: self
        real(KREAL)                                                         :: GetStandardDeviation
        GetStandardDeviation = self%standardDeviation
    end function GetStandardDeviation

    ! ------------------------
    ! Other methods.
    ! ------------------------
    function GenerateRandomValue(self) result (coord)
        type (GaussianDistributor), intent(inout)                           :: self
        real(KREAL)                                                         :: coord,random
        real(KREAL)                                                         :: gaussVal
        call LogMessage(log, TRACE_LOGGING_LEVEL, 'Entered GenerateRandomValue')
        
        random = 1.0_KREAL
        gaussVal = 0.0_KREAL
        do while ( random > gaussVal )
            ! Choose random value of coord in a 3 standard deviation range from zero
            call random_number(coord)
            coord = 3.0 * self%standardDeviation * (2.0 * coord - 1.0)
        
            ! Calculate value of gaussian function (normal curve)
            gaussVal = exp(-1.0_KREAL / (2.0 * self%standardDeviation**2) * coord**2)
        
            ! Generate a second random number, and test it against the gaussian value
            call random_number(random)
        enddo
        
        call LogMessage(log, DEBUG_LOGGING_LEVEL, 'The random number is', coord)
        call LogMessage(log, TRACE_LOGGING_LEVEL, 'Exiting GenerateRandomValue')
    end function GenerateRandomValue

    ! ------------------------
    ! Output properties.
    ! ------------------------
    subroutine OutputPropertiesPrivate(self, writer)
        type (GaussianDistributor), intent(in)                              :: self
        type (OutputWriter), intent(inout)                                  :: writer
    
        ! Write details of ADT instance to the writer
        call Write(writer, 'Standard Deviation', self%standardDeviation)
    
    end subroutine OutputPropertiesPrivate

end module GaussianDistributorModule