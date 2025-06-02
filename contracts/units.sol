// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   units.sol - mirage-manager
 *   Copyright (C) 2025-Present SKALE Labs
 *   @author Dmytro Stebaiev
 *
 *   mirage-manager is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   mirage-manager is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with mirage-manager.  If not, see <https://www.gnu.org/licenses/>.
 */

pragma solidity ^0.8.24;

type Mirage is uint256;

using {
    _mirageAdd as +,
    _mirageEqual as ==,
    _mirageGreater as >,
    _mirageSub as -
} for Mirage global;

function _mirageAdd(Mirage a, Mirage b) pure returns (Mirage sum) {
    return Mirage.wrap(Mirage.unwrap(a) + Mirage.unwrap(b));
}

function _mirageEqual(Mirage a, Mirage b) pure returns (bool equal) {
    return Mirage.unwrap(a) == Mirage.unwrap(b);
}

function _mirageGreater(Mirage a, Mirage b) pure returns (bool greater) {
    return Mirage.unwrap(a) > Mirage.unwrap(b);
}

function _mirageSub(Mirage a, Mirage b) pure returns (Mirage subtraction) {
    return Mirage.wrap(Mirage.unwrap(a) - Mirage.unwrap(b));
}
