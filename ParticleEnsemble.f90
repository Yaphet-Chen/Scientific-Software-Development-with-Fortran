!D.10. ParticleEnsemble.f90
module ParticleEnsembleModule
    use NumberKinds
    use OutputWriterModule
    use LoggerModule
    implicit none

    private
    public Particle, ParticleEnsemble, New, Delete, Assignment(=), OutputProperties
    public GetParticleMass, GetNumberOfParticles
    public AddParticle, GetParticleAtIndex, SetParticleAtIndex, RemoveAllParticles
    save

    type Particle
        real(KREAL)                                                             :: position
    end type Particle

    type ParticleEnsemble
        private
        real(KREAL)                                                             :: particleMass
        integer(KINT)                                                           :: numParticles
        type(Particle), pointer                                                 :: particles(:)
    end type ParticleEnsemble

    ! Overloaded procedure interfaces
    interface New
        module procedure NewPrivate, NewCopyPrivate
    end interface New

    interface Delete
        module procedure DeletePrivate
    end interface Delete

    interface Assignment(=)
        module procedure AssignPrivate
    end interface Assignment(=)

    interface OutputProperties
        module procedure OutputPropertiesPrivate
    end interface OutputProperties

    ! Logging
    type (Logger)                                                               :: log
    integer(KINT), parameter                                                    :: LOGGING_LEVEL = WARNING_LOGGING_LEVEL

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
    subroutine NewPrivate(self, particleMass)
        type (ParticleEnsemble), intent(out)                                    :: self
        real(KREAL)                                                             :: particleMass

        self%particleMass = particleMass
        self%numParticles = 0
        allocate(self%particles(100)) ! Allocate enough space for 100 particles
        call InitLogger
    end subroutine NewPrivate

    subroutine NewCopyPrivate(self, other)
        type (ParticleEnsemble), intent(out)                                    :: self
        type (ParticleEnsemble), intent(in)                                     :: other
        integer(KINT)                                                           :: i

        self%particleMass = other%particleMass
        self%numParticles = other%numParticles

        allocate(self%particles(other%numParticles))
        self%particles(:self%numParticles) = other%particles(:self%numParticles)

    end subroutine NewCopyPrivate

    subroutine DeletePrivate(self)
        type (ParticleEnsemble), intent(inout)                                  :: self
        integer(KINT)                                                           :: i
        deallocate(self%particles)
    end subroutine DeletePrivate

    subroutine AssignPrivate(self, other)
        type (ParticleEnsemble), intent(inout)                                  :: self
        type (ParticleEnsemble), intent(in)                                     :: other
        integer(KINT)                                                           :: i

        call Delete(self)
        call New(self, other)
    end subroutine AssignPrivate

    ! ------------------------
    ! Accessors.
    ! ------------------------
    function GetParticleMass(self)
        type (ParticleEnsemble), intent(in)                                     :: self
        real(KREAL)                                                             :: GetParticleMass
        GetParticleMass = self%particleMass
    end function GetParticleMass

    function GetNumberOfParticles(self)
        type (ParticleEnsemble), intent(in)                                     :: self
        integer(KINT)                                                           :: GetNumberOfParticles
        GetNumberOfParticles = self%numParticles
    end function GetNumberOfParticles
    
    function GetParticleAtIndex(self, index) result(p)
        type (ParticleEnsemble), intent(in)                                     :: self
        integer(KINT), intent(in)                                               :: index
        type (Particle)                                                         :: p
        p = self%particles(index)
    end function GetParticleAtIndex
    
    subroutine SetParticleAtIndex(self, index, p)
        type (ParticleEnsemble), intent(inout)                                  :: self
        integer(KINT), intent(in)                                               :: index
        type (Particle), intent(in)                                             :: p
        call GrowParticlesArray(self, index)
        self%particles(index) = p
    end subroutine SetParticleAtIndex

    ! ------------------------
    ! Other methods.
    ! ------------------------
    subroutine GrowParticlesArray(self, minSize)
        type(ParticleEnsemble), intent(inout)                                   :: self
        integer(KINT), intent(in)                                               :: minSize

        integer(KINT)                                                           :: newSize
        type(Particle), pointer                                                 :: tempParticles(:)
        if ( minSize > size(self%particles) ) then
            ! allocate a new array that is at least twice as big as the old one, copy
            ! across existing particles. Then clean up the old array, and reset pointer.
            newSize = max(size(self%particles), minSize) * 2
            allocate( tempParticles(newSize) )
            tempParticles(:self%numParticles) = self%particles(:self%numParticles)
            deallocate(self%particles)
            self%particles => tempParticles
        end if

    end subroutine GrowParticlesArray

    subroutine AddParticle (self, p)
        type(ParticleEnsemble), intent(inout)                                   :: self
        type(Particle), intent(in)                                              :: p

        call GrowParticlesArray(self, self%numParticles+1)
        self%particles(self%numParticles+1) = p
        self%numParticles = self%numParticles + 1

    end subroutine AddParticle

    subroutine RemoveAllParticles (self)
        type(ParticleEnsemble), intent(inout)                                   :: self
        integer(KINT)                                                           :: i
        self%numParticles = 0
    end subroutine RemoveAllParticles

    ! ------------------------
    ! Output properties.
    ! ------------------------
    subroutine OutputPropertiesPrivate(self, writer)
        type (ParticleEnsemble), intent(in)                                     :: self
        type (OutputWriter), intent(inout)                                      :: writer

        integer(KINT)                                                           :: i

        ! Write details of ADT instance to the writer
        call Write(writer, 'Particle Mass', self%particleMass)
        call Write(writer, 'Number of Particles', self%numParticles)

        ! write the particles
        call StartSection(writer, 'Particles in Ensemble')
        do i = 1, self%numParticles
            call Write(writer, 'Particle Index', i)
            call Write(writer, 'Position of Particle', self%particles(i)%position)
        end do
        call EndSection(writer)

    end subroutine OutputPropertiesPrivate
    
end module ParticleEnsembleModule