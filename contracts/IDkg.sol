// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   IDkg.sol - playa-manager
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

pragma solidity ^0.8.24;

import {ICommittee} from "./ICommittee.sol";
import {INodes, NodeId} from "./INodes.sol";


type DkgId is uint256;

interface IDkg {
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

    function initialize(address initialAuthority, ICommittee committeeAddress, INodes nodesAddress) external;
    function alright(DkgId dkg) external;
    function broadcast(
        DkgId dkg,
        G2Point[] memory verificationVector,
        KeyShare[] memory secretKeyContribution
    ) external;
    function generate(NodeId[] calldata nodes) external returns (DkgId dkgId);
    function isNodeBroadcasted(DkgId dkg, NodeId node) external view returns (bool broadcasted);
}
