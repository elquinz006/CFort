module contacts
use ISO_C_BINDING
implicit none

    integer, parameter :: max_size = 3600;

    type, bind(c) :: contactside
        INTEGER(c_int) :: n
        REAL(c_double) :: elasticity, poisson
        REAL(c_double) :: radius(max_size), crown(max_size)
    end type

    contains

    !  FUNCTIONS/SUBROUTINES exported from dll:
    subroutine Hertz(load, side1, side2) bind(c)
    implicit none
    !DEC$ ATTRIBUTES DLLEXPORT::Hertz
    ! Arguments
    REAL(c_double),value,intent(in) :: load
    TYPE(contactside),intent(in)    :: side1, side2

    ! Implementation omitted
    end subroutine Hertz

end module