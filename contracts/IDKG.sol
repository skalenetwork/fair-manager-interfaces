// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   IDKG.sol - playa-manager
 *   Copyright (C) 2025-Present SKALE Labs
 *   @author Dmytro Stebaiev
 *
 *   playa-manager is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   playa-manager is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with playa-manager.  If not, see <https://www.gnu.org/licenses/>.
 */

// cspell:words IDKG

pragma solidity >=0.8.24 <0.9.0;

type DKGId is bytes32;

interface IDKG {
    struct Fp2Point {
        uint256 a;
        uint256 b;
    }

    struct G2Point {
        Fp2Point x;
        Fp2Point y;
    }

    struct KeyShare {
        bytes32[2] publicKey;
        bytes32 share;
    }

    function alright() external;
    function broadcast(
        G2Point[] memory verificationVector,
        KeyShare[] memory secretKeyContribution
    ) external;
    function generate() external returns (DKGId dkgId);
}
