%module swig_test_mod
%{
#define PY_ARRAY_UNIQUE_SYMBOL LSST_SWIG_TEST_NUMPY_ARRAY_API
#include "numpy/arrayobject.h"
#include "lsst/ndarray/python.hpp"
#include <Eigen/Array>
%}
%init %{
    import_array();
%}

%include "lsst/ndarray/ndarray.i"

%declareNumPyConverters(Eigen::MatrixXd);
%declareNumPyConverters(Eigen::Matrix2d);
%declareNumPyConverters(lsst::ndarray::Array<double,1,1>);
%declareNumPyConverters(lsst::ndarray::Array<double const,1,1>);
%declareNumPyConverters(lsst::ndarray::Array<double,3>);
%declareNumPyConverters(lsst::ndarray::Array<double const,3>);

%inline %{

Eigen::MatrixXd returnMatrixXd() {
    Eigen::MatrixXd r(5, 3);
    for (int n = 0; n < r.size(); ++n) {
        r.data()[n] = n;
    }
    return r;
}

Eigen::Matrix2d returnMatrix2d() {
    Eigen::Matrix2d r;
    for (int n = 0; n < r.size(); ++n) {
        r.data()[n] = n;
    }
    return r;
}

lsst::ndarray::Array<double,1,1> returnArray1() {
    lsst::ndarray::Array<double,1,1> r(lsst::ndarray::allocate(lsst::ndarray::makeVector(6)));
    for (int n = 0; n < r.getSize<0>(); ++n) {
        r[n] = n;
    }
    return r;
}

lsst::ndarray::Array<double const,1,1> returnConstArray1() {
    return returnArray1();
}

lsst::ndarray::Array<double,3> returnArray3() {
    lsst::ndarray::Array<double,3,3> r(lsst::ndarray::allocate(lsst::ndarray::makeVector(4,3,2)));
    lsst::ndarray::Array<double,1,1> f = lsst::ndarray::flatten<1>(r);
    for (int n = 0; n < f.getSize<0>(); ++n) {
        f[n] = n;
    }
    return r;
}

lsst::ndarray::Array<double const,3> returnConstArray3() {
    return returnArray3();
}

bool acceptMatrixXd(Eigen::MatrixXd const & m1) {
    Eigen::MatrixXd m2 = returnMatrixXd();
    return m1 == m2;
}

bool acceptMatrix2d(Eigen::Matrix2d const & m1) {
    Eigen::Matrix2d m2 = returnMatrix2d();
    return m1 == m2;
}

bool acceptArray1(lsst::ndarray::Array<double,1,1> const & a1) {
    lsst::ndarray::Array<double,1,1> a2 = returnArray1();
    return lsst::ndarray::all(lsst::ndarray::equal(a1, a2));
}

bool acceptArray3(lsst::ndarray::Array<double,3> const & a1) {
    lsst::ndarray::Array<double,3> a2 = returnArray3();
    return lsst::ndarray::all(lsst::ndarray::equal(a1, a2));
}

%}