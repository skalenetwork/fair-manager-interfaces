// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   IDkg.sol - fair-manager
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

import {ICommittee} from "./ICommittee.sol";
import {INodes, NodeId} from "./INodes.sol";


type DkgId is uint256;

using {
    _dkgIdEquals as ==,
    _dkgIdNotEquals as !=
} for DkgId global;

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

    enum Status {
        SUCCESS,
        BROADCAST,
        ALRIGHT,
        FAILED
    }

    struct Round {
        DkgId id;
        Status status;
        NodeId[] nodes;
        G2Point publicKey;
        uint256 startingBlockNumber;
        uint256 numberOfBroadcasted;
        bytes32[] hashedData;
        uint256 numberOfCompleted;
        bool[] completed;
    }

    function initialize(address initialAuthority, ICommittee committeeAddress, INodes nodesAddress) external;
    function alright(DkgId dkg) external;
    function broadcast(
        DkgId dkg,
        G2Point[] memory verificationVector,
        KeyShare[] memory secretKeyContribution
    ) external;
    function generate(NodeId[] calldata nodes) external returns (DkgId dkgId);
    function getParticipants(DkgId dkg) external view returns (NodeId[] memory participants);
    function getPublicKey(DkgId dkg) external view returns (G2Point memory publicKey);
    function getRound(DkgId dkg) external view returns (Round memory round);
    function isNodeBroadcasted(DkgId dkg, NodeId node) external view returns (bool broadcasted);
}

// Slither flags as unused by interfaces but code is used
// in fair-manager implementation to overload == operant

// slither-disable-start dead-code
function _dkgIdEquals(DkgId a, DkgId b) pure returns (bool result) {
    return DkgId.unwrap(a) == DkgId.unwrap(b);
}

function _dkgIdNotEquals(DkgId a, DkgId b) pure returns (bool result) {
    return DkgId.unwrap(a) != DkgId.unwrap(b);
}
// slither-disable-end dead-code
