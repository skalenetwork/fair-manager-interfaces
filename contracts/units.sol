// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   units.sol - fair-manager
 *   Copyright (C) 2025-Present SKALE Labs
 *   @author Dmytro Stebaiev
 *
 *   fair-manager is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   fair-manager is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with fair-manager.  If not, see <https://www.gnu.org/licenses/>.
 */

pragma solidity ^0.8.24;

type Fair is uint256;
type Timestamp is uint256;

using {
    _fairAdd as +,
    _fairEqual as ==,
    _fairGreater as >,
    _fairLess as <,
    _fairSub as -
} for Fair global;

using {
    _timestampLess as <,
    _timestampAdd as +
} for Timestamp global;

// Slither flags as unused by interfaces but code is used
// in fair-manager implementation

// slither-disable-start dead-code
function _fairAdd(Fair a, Fair b) pure returns (Fair sum) {
    return Fair.wrap(Fair.unwrap(a) + Fair.unwrap(b));
}

function _fairEqual(Fair a, Fair b) pure returns (bool equal) {
    return Fair.unwrap(a) == Fair.unwrap(b);
}

function _fairGreater(Fair a, Fair b) pure returns (bool greater) {
    return Fair.unwrap(a) > Fair.unwrap(b);
}

function _fairLess(Fair a, Fair b) pure returns (bool less) {
    return Fair.unwrap(a) < Fair.unwrap(b);
}

function _fairSub(Fair a, Fair b) pure returns (Fair subtraction) {
    return Fair.wrap(Fair.unwrap(a) - Fair.unwrap(b));
}

function _timestampAdd(Timestamp a, Timestamp b) pure returns (Timestamp sum) {
    return Timestamp.wrap(Timestamp.unwrap(a) + Timestamp.unwrap(b));
}

function _timestampLess(Timestamp a, Timestamp b) pure returns (bool less) {
    return Timestamp.unwrap(a) < Timestamp.unwrap(b);
}
// slither-disable-end dead-code
