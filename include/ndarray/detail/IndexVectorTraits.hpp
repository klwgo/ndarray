// -*- c++ -*-
/*
 * Copyright (c) 2010-2016, Jim Bosch
 * All rights reserved.
 *
 * ndarray is distributed under a simple BSD-like license;
 * see the LICENSE file that should be present in the root
 * of the source distribution, or alternately available at:
 * https://github.com/ndarray/ndarray
 */
#ifndef NDARRAY_detail_IndexVectorTraits_hpp_INCLUDED
#define NDARRAY_detail_IndexVectorTraits_hpp_INCLUDED

#include <array>
#include <vector>

#include "ndarray/common.hpp"
#include "ndarray/Vector.hpp"

namespace ndarray {
namespace detail {

template <typename T>
struct IndexVectorTraits {

    static constexpr bool is_specialized = false;

};

template <typename U, std::size_t N>
struct IndexVectorTraits<Vector<U,N>> {

    static constexpr bool is_specialized = true;

    template <std::size_t M>
    static void check_dims(Vector<U,N> const & v) {
        static_assert(
            M == N,
            "Index vector has wrong number of elements."
        );
    }

    static size_t get_size(Vector<U,N> const & v, std::size_t n) {
        return v[n];
    }

    static offset_t get_offset(Vector<U,N> const & v, std::size_t n) {
        return v[n];
    }

};

template <typename U, std::size_t N>
struct IndexVectorTraits<std::array<U,N>> {

    static constexpr bool is_specialized = true;

    template <std::size_t M>
    static void check_dims(std::array<U,N> const & v) {
        static_assert(
            M == N,
            "Index vector has wrong number of elements."
        );
    }

    static size_t get_size(std::array<U,N> const & v, std::size_t n) {
        return v[n];
    }

    static offset_t get_offset(std::array<U,N> const & v, std::size_t n) {
        return v[n];
    }

};

template <typename U>
struct IndexVectorTraits<std::initializer_list<U>> {

    static constexpr bool is_specialized = true;

    template <std::size_t M>
    static void check_dims(std::initializer_list<U> const & v) {
        assert(M == v.size());
    }

    static size_t get_size(std::initializer_list<U> const & v, std::size_t n) {
        return v.begin()[n];
    }

    static offset_t get_offset(std::initializer_list<U> const & v, std::size_t n) {
        return v.begin()[n];
    }

};

template <typename U>
struct IndexVectorTraits<std::vector<U>> {

    static constexpr bool is_specialized = true;

    template <std::size_t M>
    static void check_dims(std::vector<U> const & v) {
        assert(M == v.size());
    }

    static size_t get_size(std::vector<U> const & v, std::size_t n) {
        return v[n];
    }

    static offset_t get_offset(std::vector<U> const & v, std::size_t n) {
        return v[n];
    }

};


} // namespace detail
} // ndarray

#endif // !NDARRAY_detail_IndexVectorTraits_hpp_INCLUDED